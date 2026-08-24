#!/usr/bin/env bash
#
# 同一オーナーの他リポジトリで公開されている GitHub Pages を検出し、
# Jekyll のデータファイル _data/external_pages.yml を生成する。
#
# 生成物は Git 管理しない (.gitignore 済み) ため、ローカルでサイトを
# ビルドする前にこのスクリプトを実行すること:
#
#   ./script/gen-external-pages.sh && bundle exec jekyll build
#
# CI では .github/workflows/pages.yml が Jekyll ビルドの前に実行する。
#
# 検出は 2 段階:
#   1. リポジトリ一覧 API の has_pages で候補を絞る (gh CLI の認証を使う。
#      公開情報なので GITHUB_TOKEN で足りる)。
#   2. 公開 URL に実際に HTTP アクセスして生存を確認する。
#      Pages API (/repos/{owner}/{repo}/pages) は当該リポジトリへの権限を持つ
#      認証を要求し、ワークフローの GITHUB_TOKEN は自リポジトリにしか
#      権限が無いため他リポジトリでは 404 になる。HTTP プローブなら認証不要で、
#      かつ「閲覧者がリンクを踏んで実際に開けるか」を直接確認できる。
#
# 掲載する URL は安定した https://{owner}.github.io/{repo}/ に固定する。
# カスタムドメインが設定されていても GitHub 側が恒久リダイレクトを返すため、
# リダイレクト先をそのまま埋め込む必要は無い。到達確認ではリダイレクトを追うが、
# HTTPS 以外への遷移は拒否する。
#
# 404 は「Pages が公開されていない」とみなして除外するが、それ以外の失敗
# (ネットワーク断・5xx・タイムアウト等) では中断して異常終了する。中途半端な
# 一覧でデプロイして既存の正しいページを壊さないため。

set -euo pipefail

OWNER="${PAGES_INDEX_OWNER:-applejxd}"
SELF_REPO="${PAGES_INDEX_SELF_REPO:-${OWNER}.github.io}"

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
out_file="${repo_root}/_data/external_pages.yml"

for cmd in gh jq curl; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "error: '$cmd' が必要です" >&2
    exit 1
  fi
done

# has_pages が真で、fork / archived / private / 自リポジトリを除いたものを
# 更新日時の新しい順に並べる。has_pages は Pages を無効化した後も真のまま
# 残ることがあるため、ここでは候補の抽出にとどめる。
candidates="$(
  gh api --paginate "users/${OWNER}/repos?per_page=100&type=owner" \
    --jq '.[]
      | select(.has_pages and (.fork | not) and (.archived | not) and (.private | not))
      | {name, description: (.description // ""), updated_at}' |
    jq -s --arg self "$SELF_REPO" \
      'map(select(.name != $self)) | sort_by(.updated_at) | reverse'
)"

entries='[]'
# jq の失敗を検知できるよう、ループへ流し込む前に一度変数へ受ける。
# プロセス置換のままだと生成側の異常終了が親シェルに伝わらない。
repo_names="$(jq -r '.[].name' <<<"$candidates")"

while IFS= read -r repo; do
  [ -n "$repo" ] || continue

  probe_url="https://${OWNER}.github.io/${repo}/"

  if ! status="$(curl -sS -L --proto '=https' --proto-redir '=https' \
    --max-time 30 --retry 3 --retry-delay 2 --retry-max-time 120 \
    --retry-all-errors -o /dev/null -w '%{http_code}' "$probe_url")"; then
    echo "error: ${probe_url} への接続に失敗しました" >&2
    exit 1
  fi

  case "$status" in
    2??)
      : # 公開中
      ;;
    404 | 410)
      echo "skip: ${repo} (${probe_url} が ${status})" >&2
      continue
      ;;
    *)
      echo "error: ${probe_url} が予期しない状態を返しました (${status})" >&2
      exit 1
      ;;
  esac

  entries="$(
    jq -n \
      --argjson entries "$entries" \
      --argjson candidates "$candidates" \
      --arg repo "$repo" \
      --arg url "$probe_url" \
      '($candidates[] | select(.name == $repo)) as $c
       | $entries + [{name: $c.name, url: $url, description: $c.description, updated_at: $c.updated_at}]'
  )"
done <<<"$repo_names"

mkdir -p "$(dirname "$out_file")"

# 値は JSON 文字列として書き出す。JSON 文字列は YAML としても妥当なので、
# 引用符やコロンを含む description があっても壊れない。
jq -r '
  if length == 0 then
    "[]"
  else
    .[]
    | "- name: \(.name | tojson)\n" +
      "  url: \(.url | tojson)\n" +
      "  description: \(.description | tojson)\n" +
      "  updated_at: \(.updated_at | tojson)"
  end
' <<<"$entries" >"$out_file"

echo "wrote $(jq 'length' <<<"$entries") entries to ${out_file}" >&2

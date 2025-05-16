---
title: Git メモ
---

## 基本

- [図解Git](https://marklodato.github.io/visual-git-guide/index-ja.html)
- [Git Flow ブランチモデル](https://qiita.com/kaitoland/items/5c98f60e33658c4433ef)
- [CHANGELOG の書き方](https://blog.yux3.net/entry/2017/05/04/035811)
- [submodule の仕組みと使い方](https://www.m3tech.blog/entry/git-submodule)

## 各種設定

### ユーザ設定

```bash
git config --global user.name "Alice"
git config --global user.email alice@example.com
```

[GitHub で匿名アドレスを使う場合](https://qiita.com/sta/items/982ab68e8220a81d485c)

### リモートリポジトリ設定

- [SSH 認証の github 設定](https://zenn.dev/keikuchen/articles/cffa31d69ecaae7e91d7)
- リモートリポジトリの登録

  ```bash
  # 自分の GitHub リポジトリの設定コマンド
  git remote set-url origin github:(user_name)/(repo_name).git

  git remote add origin /url/to/remote/repo
  git push -u origin main
  ```

- リモートリポジトリの変更

  ```bash
  #  [リモートリポジトリの移動](https://qiita.com/orange5405/items/783b74667bcc69a34a52)（タグは移動できない様子）
  git clone --mirror /path/to/source/repo.git
  cd repo.git
  git push --mirror /path/to/destination

  # URL変更
  git remote set-url origin /path/to/new/url
  ```

- リモートリポジトリの作成

  ```bash
  cd /path/to/remote/repo
  git init --bare --shared
  cd /path/to/local/repo
  git remote add origin /path/to/remote/repo
  ```

### gitignore 設定

- [gitignore.io](https://www.toptal.com/developers/gitignore)
- [追加したファイルを除外](https://tinyurl.com/yne4h7hc)

  ```bash
  git rm --cached hoge
  ```

- [.gitignore でホワイトリスト](https://qiita.com/officemove/items/b0409cb1ee946edadc3e)

  ```bash
  *
  !*/
  !/.gitignore
  ```

## ブランチ操作

```shell
# リモートブランチをチェックアウト
git checkout -b develop origin/develop

# デフォルトブランチの変更：master → main
git branch -m master main
git fetch origin
git branch -u origin/main main

# 一部まで push
git push origin [commit_ID]:refs/heads/[branch_name]
```

### 全コミットを一つにまとめる

```bash
# 新しいブランチ作成・全てステージング
git checkout --orphan new-branch
git add -A

# コミット作成
git commit -m "Squashed commit"

# ブランチ削除・置き換え
git branch -D main
git branch -m main

#上書き
git push origin main --force
```

## リポジトリ操作

### パッチ作成

```bash
# コミットしていない変更をパッチ化
git diff > patch.patch

# 既存のコミットをパッチ化
git format-patch -3 HEAD
```

### リセット

- HEAD だけ削除：`$ git reset --soft @~`
  - コミットを削除・コミット候補は維持
  - 最新のコミットをキャンセル
- Index も削除：`$ git reset [--mixed] @`
  - 次のコミット候補をリセット・ローカルの変更を保持
  - ステージをキャンセル
- Working Tree も削除 : `$ git reset --hard @`
  - ローカルの変更も削除
  - ローカルの変更をキャンセル
- 監視対象外の内容も削除：`$ git clean -df`

### やり直し

- [現在のブランチでの実装を別ブランチに移動](https://gist.github.com/koudaiii/526707492ebc5915596e)

  ```bash
  # ローカルの変更を退避
  git stash
  # ブランチ変更
  git checkout another_branch
  #  ローカルの変更を戻す
  git stash apply
  ```

- [どうしようもないとき→ミッシングリンクを発見](https://qiita.com/tbaba/items/af563deac65d1b12de49)
  1. `$ git reflog` で HEAD 履歴確認
  2. 直前の状態に戻るなら : `$ git reset —hard HEAD@{1}`

## Tips

- [HEAD の指定](https://qiita.com/chihiro/items/d551c14cb9764454e0b9)
  - alias として @ が使える
  - @~[n] : n回、1番目の親をたどる
  - @^[n] : n番目の親をたどる
  - (ex.) @~~ と @^^ は同じ。@^2は違う。
  - (ex.) @^2~3：最初は2番目の親を1回たどり、その後毎回1番目の親を3回たどる

### コマンド等

- [tig](https://qiita.com/suino/items/b0dae7e00bd7165f79ea)
- [gitflow-avh](https://danielkummer.github.io/git-flow-cheatsheet/index.ja_JP.html)

  ```bash
  # 初期化
  git flow init

  # feature ブランチ開始
  git flow feature start test

  # feature ブランチ終了
  git flow feature finish test

  # リリース開始
  git flow release start 0.1.0

  # CHANGELOG.md 編集など

  # リリース終了
  # マージのメッセージはそのまま・タグ生成時にメッセージを追加
  git flow release finish
  ```

## その他

### プラグイン等

- Vscode 向け
  - GitLens, Git Graph, Git History

---
title: OSS メモ
---

## gitea

- [QNAP & gitea](https://qiita.com/YKInoMT/items/b9b9c5d8616fd098d60a)

## セルフホスト Overleaf

- Docker で環境構築
- [toolkit](https://github.com/overleaf/toolkit/blob/master/doc/quick-start-guide.md) で簡単設定

```bash
git clone https://github.com/overleaf/toolkit.git ./overleaf-toolkit
cd ./overleaf-toolkit

# 設定テンプレートコピー
bin/init

# see https://github.com/overleaf/toolkit/blob/master/doc/overleaf-rc.md
# 全ての IP からのアクセスを許可
sed -i 's/^OVERLEAF_LISTEN_IP=.*/OVERLEAF_LISTEN_IP=0.0.0.0/' config/overleaf.rc
# ポート番号を変更（WSL2 の場合は Windows 側でこのポートをフォワード）
sed -i 's/^OVERLEAF_PORT=.*/OVERLEAF_PORT=58888/' config/overleaf.rc
# Pro のみ有効な機能なので false にする
sed -i 's/^SIBLING_CONTAINERS_ENABLED=.*/SIBLING_CONTAINERS_ENABLED=false/' config/overleaf.rc

# キャッシュクリアをする場合
rm -rf data/
git reset --hard @

# 起動
bin/up

# http://localhost:port/launchpad にアクセスしアカウント作成

# アタッチ
bin/shell

# TeXLive 更新 (日本語対応)
tlmgr update --self
tlmgr install scheme-full
exit

# イメージ更新 & 起動
docker commit sharelatex sharelatex/sharelatex:5.1.1-with-texlive-full
echo 5.1.1-with-texlive-full > config/version
bin/up
```

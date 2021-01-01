---
title: Git メモ
---

## 基本
- [図解Git](https://marklodato.github.io/visual-git-guide/index-ja.html)
- 使い始める
	```bash
	$ git config --global user.name "Alice"
	$ git config --global user.email alice@example.com
	```
- [HEAD の指定](https://qiita.com/chihiro/items/d551c14cb9764454e0b9)
	- alias として @ が使える
	- @~[n] : n回、1番目の親をたどる
	- @^[n] : n番目の親をたどる
	- (ex.) @~~ と @^^ は同じ。@^2は違う。
	- (ex.) @^2~3：最初は2番目の親を1回たどり、その後毎回1番目の親を3回たどる
- [CHANGELOG の書き方](https://blog.yux3.net/entry/2017/05/04/035811)

## リポジトリ設定

- [gitignore.io](https://www.toptal.com/developers/gitignore)
- [.gitignore でホワイトリスト](https://qiita.com/officemove/items/b0409cb1ee946edadc3e)
	```
	*
	!*/
	!/.gitignore
	```
	- リモートリポジトリの作成
	```bash
	$ cd /path/to/remote/repo
	$ git init --bare --shared
	$ cd /path/to/local/repo
	$ git remote add origin /path/to/remote/repo
	```
- [リモートリポジトリの移動](https://qiita.com/orange5405/items/783b74667bcc69a34a52)
	- タグは移動できない様子
	```bash
	$ git clone --mirror /path/to/source/repo.git
	$ cd repo.git
	$ git push --mirror /path/to/destination
	```

## [リセットしたいとき](http://tinyurl.com/yyl8ltp7)

### やり直し

- [現在のブランチでの実装を別ブランチに移動](https://gist.github.com/koudaiii/526707492ebc5915596e)
	```bash
	$ git stash		# ローカルの変更を退避
	$ git checkout another_branch	# ブランチ変更
	$ git stash apply	# ローカルの変更を戻す	
	```

- [どうしようもないとき→ミッシングリンクを発見](https://qiita.com/tbaba/items/af563deac65d1b12de49)
	1. `$ git reflog` で HEAD 履歴確認
	2. 直前の状態に戻るなら : `$ git reset —hard HEAD@{1}`

### リセット

- HEAD だけ削除：`$ git reset --soft @~`
	- コミットを削除・コミット候補は維持
	- 最新のコミットをキャンセル : 
- Index も削除：`$ git reset [--mixed] @`
	- 次のコミット候補をリセット・ローカルの変更を保持
	- ステージをキャンセル
- Working Tree も削除 : `$ git reset --hard @`
	- ローカルの変更も削除
	- ローカルの変更をキャンセル
- 監視対象外の内容も削除：`$ git clean -df`

## ツール

- [gitflow-avh](https://danielkummer.github.io/git-flow-cheatsheet/index.ja_JP.html)
	```bash
	$ git flow init	# 初期化
	$ git flow feature start test	# feature ブランチ開始
	$ ...
	$ git flow feature finish test	# feature ブランチ終了
	$ git flow release start 0.1.0 # リリース開始
	$ # CHANGELOG.md 編集
	$ git flow release finish
	$ # マージのメッセージはそのまま
	$ # タグ生成時にメッセージを追加
	```
- [tig](https://qiita.com/suino/items/b0dae7e00bd7165f79ea)
- Vscode 向け
	- GitLens, Git Graph, Git History
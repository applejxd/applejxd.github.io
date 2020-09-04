---
title: Git メモ
---

## 基本
- [図解Git](https://marklodato.github.io/visual-git-guide/index-ja.html)
- [HEAD の指定](https://qiita.com/chihiro/items/d551c14cb9764454e0b9)
	- alias として @ が使える
	- @~[n] : n回、1番目の親をたどる
	- @^[n] : n番目の親をたどる
	- (ex.) @~~ と @^^ は同じ。@^2は違う。
	- (ex.) @^2~3：最初は2番目の親を1回たどり、その後毎回1番目の親を3回たどる

## [リセットしたいとき](http://tinyurl.com/yyl8ltp7)

### やり直し

- [現在のブランチでの実装を別ブランチに移動](https://gist.github.com/koudaiii/526707492ebc5915596e)
	```bash
	$ git stash		# ローカルの変更を退避
	$ git checkout another_branch	# ブランチ変更
	$ git stash apply	# ローカルの変更を戻す	
	```

- [どうしようもないとき→ミッシングリンクを発見](https://qiita.com/tbaba/items/af563deac65d1b12de49)
	1. $ git reflog で HEAD 履歴確認
	2. 直前の状態に戻るなら : $ git reset —hard HEAD@{1}

### リセットのオプション
- HEAD だけ削除（reset --soft）
	- コミットを削除・コミット候補は維持
	- 最新のコミットをキャンセル : $ git reset --soft @~
- Index も削除（reset [--mixed]）
	- 次のコミット候補をリセット・ローカルの変更を保持
	- ステージをキャンセル：$ git reset [--mixed] @
- Working Tree も削除（reset --hard）
	- ローカルの変更も削除
	- ローカルの変更をキャンセル : $ git reset --hard @

## ツール

- [gitflow-avh](https://danielkummer.github.io/git-flow-cheatsheet/index.ja_JP.html)
	```bash
	$ git flow init	# 初期化
	$ git flow feature start test	# feature ブランチ開始
	$ ...
	$ git flow feature finish test	# feature ブランチ終了
	```
- [tig](https://qiita.com/suino/items/b0dae7e00bd7165f79ea)
- Vscode 向け
	- GitLens, Git Graph, Git History
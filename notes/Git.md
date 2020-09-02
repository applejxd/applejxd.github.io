# Git メモ

- [図解Git](https://marklodato.github.io/visual-git-guide/index-ja.html)
- [HEAD の指定](https://qiita.com/chihiro/items/d551c14cb9764454e0b9)
	- alias として @ が使える
	- @~[n] : n回、1番目の親をたどる
	- @^[n] : n番目の親をたどる
	- (ex.) @~~ と @^^ は同じ。@^2は違う。
	- (ex.) @^2~3：最初は2番目の親を1回たどり、その後毎回1番目の親を3回たどる
- [間違って別のブランチで実装を始めちゃった時にgit stashで別ブランチに編集中のソースを移動する](https://gist.github.com/koudaiii/526707492ebc5915596e)
	- ローカルの変更を退避 : $ git stash
	- ブランチ変更
	- ローカルの変更を戻す : $ git stash apply

## [リセットしたいとき](http://tinyurl.com/yyl8ltp7)

- [どうしようもないとき→ミッシングリンクを発見](https://qiita.com/tbaba/items/af563deac65d1b12de49)
	1. $ git reflog で HEAD 履歴確認
	2. 直前の状態に戻るなら : $ git reset —hard HEAD@{1}
- HEAD だけ削除（reset --soft）
	- コミットを削除・コミット候補は維持
	- 最新のコミットをキャンセル : $ git reset --soft @~
- Index も削除（reset [--mixed]）
	- 次のコミット候補をリセット・ローカルの変更を保持
	- ステージをキャンセル：$ git reset [--mixed] @
- Working Tree も削除（reset --hard）
	- ローカルの変更も削除
	- ローカルの変更をキャンセル : $ git reset --hard @

## [ブランチの切り方](https://havelog.ayumusato.com/develop/git/e513-git_branch_model.html)

- git flow コマンドを使う
- feature ブランチ
- release ブランチ
	- develop の内容を master に適用
	- develop から切る
	- リリースバージョンの tag をつける
- hotfix ブランチ
	- master から一時的に修正
	- master から切る
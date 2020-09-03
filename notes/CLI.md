# CLI メモ

## ターミナル操作

- (Mac のシェルは.terminalでGUIとして実行)

### コマンド操作

- [fzf (fuzzy finder)](https://wonderwall.hatenablog.com/entry/2017/10/06/063000)
	- C-t：カレントディレクトリ以下検索
	- C-r：コマンド履歴検索
	- M-c：検索しながら移動
- 事前コマンドを実行
	```
	$ !!
	```
- 事前のコマンドの foo を bar に入れ替えて実行：$ ^foo^bar
	```bash
	$ ls -a
	$ ^-a ^-la	# ls -la と同じ
	```

### ジョブ管理

- プロセス終了：Ctrl+C
- プロセス中断：Ctrl+Z
- ジョブ操作の基本
	```bash
	$ [command] &		#バックグラウンドジョブとして実行
	$ kill %<Job No.>	# ジョブを停止
	$ jobs				# ジョブ確認
	$ bg %<Job No.>		# バックグラウンド処理
	$ fg %<Job No.>		# フォアグラウンド処理
	```
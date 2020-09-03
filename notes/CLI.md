# CLI メモ

## ターミナル操作編

- (Mac のシェルは.terminalでGUIとして実行)

### コマンド操作関連

- [fzf (fuzzy finder)](https://wonderwall.hatenablog.com/entry/2017/10/06/063000)
	- C-t：カレントディレクトリ以下検索
	- C-r：コマンド履歴検索
	- M-c：検索しながら移動
- 事前コマンドを実行 → $ !!
- 事前のコマンドの foo を bar に入れ替えて実行 → $ ^foo^bar
	- [例] $ ls -a → $ ^-a ^-la

### ジョブ管理

- バックグラウンドジョブとして実行 → $ [command] &
- ジョブを停止 → $ kill %<#Job>
- プロセス終了 → Ctrl+C
- プロセス中断 → Ctrl+Z
	- ジョブ確認 → $ jobs 
	- バックグラウンド処理 → $ bg %<#Job>
	- フォアグラウンド処理 → $ fg %<#Job>

### ディレクトリスタック

- $ pushd
	- オプション無し: pwd をスタックに積んで引数のディレクトリに移動
	- +n: n 番目のスタックに移動
- $ dirs
	- 現在のスタック一覧を表示
- $ popd
	- +n: n 番目のスタックを削除

### [リダイレクト](https://qiita.com/laikuaut/items/e1cc312ffc7ec2c872fc)

- ファイル・ディスクリプター
	- stdin（入力のデフォルト）：0
	- stdout（出力のデフォルト）：1
	- stderr：2
	- その他：3, 4, ...
- 演算子
	- [n]<word：n に入力（word を n で読み込み・参照）
	- [n]>word：n を出力（word を n で書き込み・参照）
	- [n]>>word：n を追加出力（word を n で書き込み・参照）
	- [n]>&word：出力の複製（word の複製を n で書き込み・参照）
- ケーススタディ
	- command > file 2>&1
		- command > file：1 → file
		- 2>&1：2 → (1 → file のコピー)
		- command の stdout と stderr のどちらも file に書き出し
	- command 2>&1 > file
		- command 2>&1：2 → (1 → stdout のコピー)
		- > file：1 → file
		- command の stdout を file に、stderr を stdout に

### 置換

- コマンド置換：$(command)
- プロセス置換：<(command)

## コマンド編

- データ処理関連は Pandasを使うて手も

### grep

検索処理。パイプでand検索。
- $ grep [RegExp]
- pwd 以下のファイルを再帰的に検索
	- $ grep -rl [RegExp]
- [RegExp]を含む行を表示
	- $ grep [RegExp] [Filename]
- 検索オプション
	- -r: カレントディレクトリ以下を再帰的に検索
	- -i: 大文字と小文字の区別をしない
	- -w: 検索を単語として行う
- 表示オプション
	- -l: ファイル名のみ表示
	- -n: マッチした行番号も表示
	- -h: マッチしたファイル名も表示
	- -v: 文字列を除く行をすべて表示

### sed (Stream EDitor)

置換処理
- $ sed -e "s/置換条件/置換文字/g"
- Tips

### awk

抽出処理
- 使用例: $ awk -F'[,]' -v 'OFS=,' '{print $1, $NF}'
- -F: 読み込みデータの区切り文字（複数指定可）
- -v: 変数指定
	- OFS: 区切り文字（書き出し）
	- RS: レコードの区切り文字（改行相当・読み込み）
	- ORS: レコードの区切り文字（改行相当・書き出し）
- 出力変数
	- $0: すべてのデータ
	- $1,$2,... : 1,2,.. 個目のデータ
	- $NF: 最後のデータ
	- $NF-1: 最後から二番目のデータ

### その他データ処理

- join: データ結合（複数フィールドは awk で[:]区切りで1フィールド目に結合して使う）
- sort: データの並び替え
- cat, paste: 単純に縦・横にデータ結合

### chmod

- 基本
	1. ディレクトリ:755[drwxr-xr-x]
	2. 通常のファイル:644[-rw-r--r--]
	3. secureなファイル:444 [-r--r--r--]
- 一括変更
	1. $ sudo find . -type d -print | xargs sudo chmod 755
	2. $ sudo find . -type f -print | xargs sudo chmod 644
	3. $ sudo find . -type f -print | xargs sudo chmod 444

### nkf

文字コードを変換して標準出力。
- $ nkf -w before.dat > after.dat
	- -w: UTF-8
	- -s: Shift_JIS
	- -e: EUC-JP
- —overwrite: 上書き
	- $ nkf -w —overwrite hoge.dat
- --guess: 文字コード判定
	- $ nkf --guess hoge.dat

### convert

- 画像・pdfファイルの相互変換
- $ convert [変換前ファイル] [変換後ファイル]

### その他

- which: コマンドの有無・絶対パスの確認
- find: ファイル・ディレクトリの検索
    - $ find [検索ディレクトリ] -name [名前]
    - -delete: 削除もする
    - xargs で渡す
	    - findとxargsの基本的な使い方
	    - xargs コマンド|コマンドの使い方
- jman: 日本語マニュアルの表示(要インストール)
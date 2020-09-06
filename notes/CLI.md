---
title: CLI メモ
---

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

```bash
$ command &	#バックグラウンドジョブとして実行
$ kill %<Job No.>	# ジョブを停止
$ jobs	# ジョブ確認
$ bg %<Job No.>	# バックグラウンド処理
$ fg %<Job No.>	# フォアグラウンド処理
```
- プロセス終了：Ctrl+C
- プロセス中断：Ctrl+Z

### ディレクトリスタック

```bash
$ push	# pwd をスタックに積んで引数のディレクトリに移動
$ push +n	# n 番目のスタックに移動
$ dirs	# 現在のスタック一覧を表示
$ popd +n	# n 番目のスタックを削除
```

### [リダイレクト](https://qiita.com/laikuaut/items/e1cc312ffc7ec2c872fc)

- ファイル・ディスクリプター(FD)
	- stdin（入力のデフォルト）：0
	- stdout（出力のデフォルト）：1
	- stderr：2
	- その他：3, 4, ...
- 演算子
	- [n]<word：n に入力（word を n で読み込み・参照）
	- [n]\>word：n を出力（word を n で書き込み・参照）
	- [n]\>\>word：n を追加出力（word を n で書き込み・参照）
	- [n]\>&word：出力の複製（word の複製を n で書き込み・参照）
- ケーススタディ
	- stdout と stderr の両方を file に書き出し
		```bash
		$ command > file 2>&1
		```
		- command \> file (FD1 := file)
		- 2 \>&1 (FD2 := FD1 のコピー = file)
	- stdout を file に. stderr を stdout に.
		```bash
		$ command 2>&1 > file
		```
		- command 2\>&1 (FD2 := FD1のコピー = stdout)
		- \> file (FD1 := file)

### 置換

- コマンド置換：コマンドの結果の文字列に置換
- プロセス置換：コマンドの結果を内容に持つファイルに置換
```bash
$ bash -c "$(curl -L https://raw.githubusercontent.com/applejxd/dotfiles/master/install.sh)"	# コマンド置換
$ source <(curl -L https://raw.githubusercontent.com/applejxd/dotfiles/master/deploy.sh)	# プロセス置換
```

### chmod

- 基本
	1. ディレクトリ：755[drwxr-xr-x]
	2. 通常のファイル：644[-rw-r--r--]
	3. secureなファイル：444 [-r--r--r--]
- 一括変更
```bash
$ sudo find . -type d -print | xargs sudo chmod 755
$ sudo find . -type f -print | xargs sudo chmod 644
$ sudo find . -type f -print | xargs sudo chmod 444
```

## ファイル検索

ファイル名検索は find で.
ファイル内容検索は grep で.

### [find](https://webkaru.net/linux/find-command/)
ファイル名検索
```
$ find [検索ディレクトリ] -name [名前]
```
- -delete: 削除もする
- xargs で渡す
	```bash
	find . -name "*.dat" -type f | xargs wc -l
	```
	- [findとxargsの基本的な使い方](https://webkaru.net/linux/find-command/)
	- [xargs コマンド|コマンドの使い方](https://hydrocul.github.io/wiki/commands/xargs.html)

### [grep](https://webkaru.net/linux/grep-command/)
ファイル内容検索. パイプでand検索.
```bash
$ grep RegExp
$ grep -rl RegExp	# pwd 以下のファイルを再帰的に検索
$ grep RegExp Filename	# RegExp を含む行を表示
```
- 検索オプション
	- -r: カレントディレクトリ以下を再帰的に検索
	- -i: 大文字と小文字の区別をしない
	- -w: 検索を単語として行う
- 表示オプション
	- -l: ファイル名のみ表示
	- -n: マッチした行番号も表示
	- -h: マッチしたファイル名も表示
	- -v: 文字列を除く行をすべて表示

## ファイル編集

- データ処理関連は Pandasを使うて手も

### [sed (Stream EDitor)](https://qiita.com/muran001/items/472abcfc353d5df7b77a)

置換処理
```bash
$ sed -e "s/置換条件/置換文字/g"
```
- [ユースケース一覧](https://qiita.com/hirohiro77/items/7fe2f68781c41777e507)

### [awk](https://qiita.com/yamazon/items/563af1b485ff413d381f)

抽出処理
```bash
$ awk -F'[,]' -v 'OFS=,' '{print $1, $NF}'
```
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

- [join](https://eng-entrance.com/linux-command-join)
: データ結合（複数フィールドは awk で[:]区切りで1フィールド目に結合して使う）
- cat, paste: 単純に縦・横にデータ結合
- [sort](https://eng-entrance.com/linux-command-sort)
: データの並び替え

## ファイル変換

### [nkf](https://webkaru.net/linux/nkf-command/)

文字コードを変換して標準出力。
```bash
$ nkf -w before.dat > after.dat
```
- 文字コード指定
	- -w: UTF-8
	- -s: Shift_JIS
	- -e: EUC-JP
- —overwrite：上書き
	```
	$ nkf -w —overwrite hoge.dat
	```
- --guess：文字コード判定
	```bash
	$ nkf --guess hoge.dat
	```

### convert

画像・pdfファイルの相互変換
```
$ convert [変換前ファイル] [変換後ファイル]
```
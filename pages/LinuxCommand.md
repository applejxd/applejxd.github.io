---
title: Linux コマンドメモ
---

## ファイル検索

ファイル名検索は find で.
ファイル内容検索は grep で.

### [find](https://webkaru.net/linux/find-command/)

ファイル名検索

```bash
$ find [検索ディレクトリ] -name [名前]
```

- -delete: 削除もする
- xargs で渡す

```bash
find . -name "*.dat" -type f | xargs wc -l
```

	- [findとxargsの基本的な使い方](https://webkaru.net/linux/find-command/)
	- [xargs コマンド - コマンドの使い方](https://hydrocul.github.io/wiki/commands/xargs.html)
- chmod を使った例

```bash
# ディレクトリ
$ sudo find . -type d -print | xargs sudo chmod 755
# 通常のファイル
$ sudo find . -type f -print | xargs sudo chmod 644
# secure なファイル
$ sudo find . -type f -print | xargs sudo chmod 444
```

### [grep](https://webkaru.net/linux/grep-command/)

テキスト（ファイル内容）検索. パイプでand検索.

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
- ユースケース集
- インストールファイル検索：`dpkg -L $package_name | grep $file_name`

## ファイル編集

- データ処理関連は Pandasを使うて手も

### [sed (Stream EDitor)](https://qiita.com/muran001/items/472abcfc353d5df7b77a)

置換処理

```bash
$ sed -e "s/置換条件/置換文字/g"
```

- [GNU sed REPL](https://sed.js.org/)：シミュレータ
- [ユースケース一覧](https://qiita.com/hirohiro77/items/7fe2f68781c41777e507)

### [awk](https://qiita.com/yamazon/items/563af1b485ff413d381f)

抽出処理

```bash
$ awk -F'[,]' -v 'OFS=,' '{print $1, $NF}'
```

- [AWK REPL](https://awk.js.org/)：シミュレータ
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

- [Linuxコマンドでテキストデータを自在に操る](https://orangain.hatenablog.com/entry/20100916/1284631280)
  - cat, paste：単純に縦・横にデータ結合
  - [join](https://eng-entrance.com/linux-command-join)
	：データ結合（複数フィールドは awk で[:]区切りで1フィールド目に結合して使う）
- [sort](https://eng-entrance.com/linux-command-sort)
：データの並び替え
- [LinuxでExcelをCSVに変換するコマンドラインツール](https://notchained.hatenablog.com/entry/2014/11/24/105410)

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

```bash
$ nkf -w —-overwrite hoge.dat
```

- --guess：文字コード判定

```bash
$ nkf --guess hoge.dat
```

### convert

画像・pdfファイルの相互変換

```bash
$ convert [変換前ファイル] [変換後ファイル]
```

## パッチ処理

### パッチ作成

- [diff を使う](https://qiita.com/astro_super_nova/items/e30dcaf4d106deebc63c)

```shell
$ diff -up original_source modified_source > source.patch
$ diff -uprN /path/to/original /path/to/modified > folder.patch
```

- [git を使う](https://qiita.com/sea_mountain/items/7d9c812e68a26bd1a292)
：`$ git diff > diff.patch`

### パッチ適用

- diff：`$ patch [option] applied_file < patch_file.patch`
- git：`$ git apply diff.patch`

## ユーザー処理

- ユーザー追加
	- ワンライナーで追加： シェル指定・ホームディレクトリ付き

```shell
$ sudo useradd -s /bin/bash -m username
```

	- ウィザードで追加：`$ sudo adduser username`
- ユーザー削除：`$ sudo userdel -r username`
- グループに追加：`$ sudo usermod -G group username`
	- sudo 権限を追加：`$ sudo usermod -aG sudo username`
- グループ確認：`$ cat /etc/group | grep username`

## その他

```shell
# os 確認
$ neofetch
```

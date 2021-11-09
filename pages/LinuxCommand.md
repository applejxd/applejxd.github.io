---
title: Linux コマンドメモ
---

## ファイル検索

ファイル名検索は find で.
ファイル内容検索は grep で.

### [find](https://webkaru.net/linux/find-command/)

```bash
find [検索ディレクトリ] -name [名前]
```

- ファイル名検索
  - -delete: 削除もする
  - xargs で渡す
- [findとxargsの基本的な使い方](https://webkaru.net/linux/find-command/)

  ```bash
  find . -name "*.dat" -type f | xargs wc -l
  ```

  - [xargs コマンド - コマンドの使い方](https://tinyurl.com/y9hzph6j)

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

```bash
grep RegExp
# pwd 以下のファイルを再帰的に検索
grep -rl RegExp
# RegExp を含む行を表示
grep RegExp Filename
```

- テキスト（ファイル内容）検索. パイプでand検索.
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

### [sed (Stream EDitor)](https://tinyurl.com/yzkfcaxv)

```bash
sed -e "s/置換条件/置換文字/g"
```

- 置換処理
- [GNU sed REPL](https://sed.js.org/)：シミュレータ
- [ユースケース一覧](https://tinyurl.com/ygo2wh2d)

### [awk](https://tinyurl.com/yhl7mvog)

```bash
awk -F'[,]' -v 'OFS=,' '{print $1, $NF}'
```

- 抽出処理
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

- [Linuxコマンドでテキストデータを自在に操る](https://tinyurl.com/ybk3fs4z)
  - cat, paste：単純に縦・横にデータ結合
  - [join](https://eng-entrance.com/linux-command-join)：データ結合（複数フィールドは awk で[:]区切りで1フィールド目に結合して使う）
- [sort](https://tinyurl.com/yhe3gzoe)：データの並び替え
- [LinuxでExcelをCSVに変換するコマンドラインツール](https://tinyurl.com/yzf9nu83)

## ファイル変換

### [nkf](https://webkaru.net/linux/nkf-command/)

```bash
nkf -w before.dat > after.dat
```

- 文字コードを変換して標準出力
- 文字コード指定
  - -w: UTF-8
  - -s: Shift_JIS
  - -e: EUC-JP
- —overwrite：上書き

  ```bash
  nkf -w —-overwrite hoge.dat
  ```

- --guess：文字コード判定

  ```bash
  nkf --guess hoge.dat
  ```

### convert

画像・pdfファイルの相互変換:`convert [変換前ファイル] [変換後ファイル]`

## パッチ処理

### パッチ作成

- [diff を使う](https://tinyurl.com/ye8jgqnw)

  ```shell
  diff -up original_source modified_source > source.patch
  diff -uprN /path/to/original /path/to/modified > folder.patch
  ```

- [git を使う](https://tinyurl.com/ybbxgynh)：`git diff > diff.patch`

### パッチ適用

- diff：`patch [option] applied_file < patch_file.patch`
- git：`git apply diff.patch`

## ユーザー処理

- ユーザー追加:`sudo useradd -s /bin/bash -m username`
  - ワンライナーで追加： シェル指定・ホームディレクトリ付き
  - ウィザードで追加：`sudo adduser username`
  - ユーザー削除：`sudo userdel -r username`
  - グループに追加：`sudo usermod -G group username`
  - sudo 権限を追加：`sudo usermod -aG sudo username`
- グループ確認：`cat /etc/group | grep username`
- SSH
  - [SSH 鍵生成](https://tinyurl.com/yhj2odla):`ssh-keygen -t ed25519 -P "" -f key_name`
    - パスワードなし:`-P ""`
    - 鍵の名前指定:`-f key-name`
  - [SSH 登録](https://tinyurl.com/yf7trmlh):`ssh-copy-id -i ~/.ssh/key_name.pub remote_url`
    - 直接行う場合は key-name.pub を登録先の ~/.ssh/authorized_keys に追記

      ```bash
      # クライアント側
      eval `ssh-agent`
      ssh-add ~/.ssh/key_name
      scp key_name.pub remote_url:~/.ssh
      # サーバ側
      cat ~/.ssh/key_name.pub >> ~/.ssh/authorized_keys
      ```

## その他

```shell
# os 確認
neofetch
```

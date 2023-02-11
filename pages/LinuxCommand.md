---
title: Linux コマンドメモ
---


- [正規表現チェッカー](https://regex101.com/)

## ファイル検索

ファイル名検索は find で.
ファイル内容検索は grep で.

### [find](https://webkaru.net/linux/find-command/)

ファイル名検索

```bash
find [検索ディレクトリ] -name [名前]
```

- オプション
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

テキスト（ファイル内容）検索. パイプでand検索.

```bash
grep RegExp
# pwd 以下のファイルを再帰的に検索
grep -rl RegExp
# RegExp を含む行を表示
grep RegExp Filename
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

### [sed (Stream EDitor)](https://www.gnu.org/software/sed/manual/sed.html)

置換処理

```bash
sed "s/置換条件/置換文字/g" input.txt > output.txt
```

- [GNU sed REPL](https://sed.js.org/)：シミュレータ
- [ユースケース一覧](https://qiita.com/hirohiro77/items/7fe2f68781c41777e507)
- 非オプションパラメータの扱い
  - スクリプト指定(-e or -f)かない:第1がスクリプト・それ以降は入力ファイル
  - 入力ファイルの指定がない:標準入力を使用
- [オプション](https://atmarkit.itmedia.co.jp/ait/spv/1610/17/news015.html)
  - -e: テキストでスクリプト指定
  - -f: ファイルでスクリプト指定
  - -i: inplace (上書き保存)。続いて文字列指定で、指定形式でのバックアップ。

### [awk](https://tinyurl.com/yhl7mvog)

抽出処理
  
```bash
awk -F'[,]' -v 'OFS=,' '{print $1, $NF}'
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

- [Linuxコマンドでテキストデータを自在に操る](https://tinyurl.com/ybk3fs4z)
  - cat, paste：単純に縦・横にデータ結合
  - [join](https://eng-entrance.com/linux-command-join)：データ結合（複数フィールドは awk で[:]区切りで1フィールド目に結合して使う）
- [sort](https://tinyurl.com/yhe3gzoe)：データの並び替え
- [LinuxでExcelをCSVに変換するコマンドラインツール](https://tinyurl.com/yzf9nu83)

## ファイル変換

### [nkf](https://webkaru.net/linux/nkf-command/)

文字コードを変換して標準出力

```bash
nkf -w before.dat > after.dat
```

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

## 自動化関連

### 自動入力・自動実行

- [expect](https://qiita.com/ine1127/items/cd6bc91174635016db9b)：ルールに従って自動入力
- [trap](https://tm.root-n.com/programming:shell_script:command:trap)：シグナル（Ctrl+C等）をトリガーとしてコマンド実行
  - [EXIT](https://shellscript.sunone.me/signal_and_trap.html)：プロセス終了時に実行
  - [mktemp の一時ファイルを削除するイディオム](https://mahata.wordpress.com/2017/11/20/%E4%B8%80%E6%99%82%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E7%A2%BA%E5%AE%9F%E3%81%AB%E5%89%8A%E9%99%A4%E3%81%99%E3%82%8B%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88/)
  
  ```bash
  tmp_file=$(mktemp)
  trap 'rm -f "$temp_file"' EXIT HUP INT QUIT TERM
  ```

### ファイル操作

- mktemp：一時ファイル生成
  - 生成ファイルはユニーク
  - 生成先は /tmp (再起動時に削除・10日間で未使用ファイル削除)
  - 削除は上記 trap コマンドを使用するイディオムを活用

## その他

```shell
# os 確認
neofetch
```

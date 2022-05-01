---
title: シェルスクリプトメモ
---

## まとめ

- [シェルスクリプト入門 書き方のまとめ](http://motw.mods.jp/shellscript/tutorial.html)
- [シェルスクリプト入門](https://web.archive.org/web/20171016064310/http://www.k4.dion.ne.jp/~mms/unix/shellscript/index.html)

## 置換

- コマンド置換：コマンドの結果の文字列に置換
- プロセス置換：コマンドの結果を内容に持つファイルに置換

```bash
bash -c "$(curl -L https://raw.githubusercontent.com/applejxd/dotfiles/master/install.sh)" # コマンド置換
source <(curl -L https://raw.githubusercontent.com/applejxd/dotfiles/master/deploy.sh) # プロセス置換
```

## [リダイレクト](https://qiita.com/laikuaut/items/e1cc312ffc7ec2c872fc)

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
  - stdout と stderr の両方を file に書き出し：`command > file 2>&1`
    - `command \> file (FD1 := file)`
    - `2 \>&1 (FD2 := FD1 のコピー = file)`
  - stdout を file に. stderr を stdout に：`command 2>&1 > file`
    - command 2\>&1 (FD2 := FD1のコピー = stdout)
    - \> file (FD1 := file)

## 実行環境に応じた分岐

### 有無に応じて処理

- コマンドの有無

    ```bash
    if type "command1" > /dev/null 2>&1; then
        command2
    fi
    ```

- ファイル書き込みの有無

    ```bash
    grep -q RegExp /file/to/path
    if [ $? -ne 0 ]; then
        command
    fi
    ```

### OS 独自の処理

- Mac OS X

    ```bash
    if [[ "$OSTYPE" == "darwin"* ]]; then
        command
    fi
    ```

- Ubuntu

    ```bash
    if [[ -e /etc/lsb-release ]]; then
        command
    fi
    ```

- Linux

    ```bash
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        command
    fi
    ```

- WSL

    ```bash
    # WSL2 のみ真
    [[ "$(uname -r)" =~ microsoft ]]
    
    # WSL2 のみ真
    [[ "$(uname -r)" =~ WSL2 ]]
    
    # WSL1 のみ真
    [[ "$(uname -r)" =~ Microsoft ]]
    
    # WSL1/WSL2/Distrod で真
    [[ "$(uname -r)" =~ (M|m)icrosoft ]]
    
    # Distrod 以外
    [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]
    ```

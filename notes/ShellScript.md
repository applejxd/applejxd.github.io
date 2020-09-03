# シェルスクリプトメモ

## まとめ

- [シェルスクリプト入門 書き方のまとめ](http://motw.mods.jp/shellscript/tutorial.html)
- [シェルスクリプト入門](https://web.archive.org/web/20171016064310/http://www.k4.dion.ne.jp/~mms/unix/shellscript/index.html)

## 有無に応じて処理

- コマンドの有無
    ```bash
    if type "command1" > /dev/null 2>&1; then
        command2
    fi
    ```
- 書き込みの有無
    ```bash
    grep -q RegExp /file/to/path
    if [ $? -ne 0 ]; then
        command
    fi
    ```

## OS 独自の処理

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
    if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
        command
    fi
    ```
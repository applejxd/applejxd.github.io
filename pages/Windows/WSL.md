---
title: WSL メモ
---

## 移行ガイド

- [WSL 2 仮想ハード ディスクのサイズを拡張する](https://learn.microsoft.com/ja-jp/windows/wsl/vhd-size)
  - [How do I get back unused disk space from Ubuntu on WSL2?](https://superuser.com/questions/1606213/how-do-i-get-back-unused-disk-space-from-ubuntu-on-wsl2)
- [WSL上のLinuxをCドライブから移動させる](https://www.aise.ics.saitama-u.ac.jp/~gotoh/HowToReplaceWSL.html)
  - 移行後はデフォルトユーザが root になることに注意
  - [/etc/wsl.conf でデフォルトユーザを指定可能](https://devlights.hatenablog.com/entry/2021/05/29/070000)
  - [Docker Desktop も同様に移行可能](https://e-penguiner.com/change-location-of-docker-on-windows/)

## インストール手順

0. [コマンドで有効化](https://docs.microsoft.com/ja-jp/windows/wsl/install-win10), appwiz.cpl (Win+R)
1. WSL1 有効化

    ```shell
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    ```

2. WSL2 に必要な設定

    ```shell
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```

3. [Linux カーネルの更新](https://docs.microsoft.com/ja-jp/windows/wsl/wsl2-kernel)
：[コマンドで実施？](https://news.mynavi.jp/article/20200620-1059833/)
4. 再起動して ver. 2 をデフォルトに

    ```shell
    wsl --set-default-version 2
    ```

5. 「Ubuntu 18.04」をインストール
6. バージョン確認

    ```shell
    wsl -l -v
    ```

## 基本設定
  
- GUI アプリ設定
  - WSLg (Microsoft Store 版 WSL) 使用時は不要

 1. Vxcsrv インストール
 2. ファイアウォールはパブリックも設定
    - 「ファイアウォールとネットワーク保護」→「ファイアウォールによるアプリケーションの許可」→「VcXsrv windows server」→パブリックを許可
 3. Xlaunch 起動時に "Disable access control" をチェック
 4. DISPLAY 環境変数を設定

 ```shell
 export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
 ```

## WSL 特有の操作

- [Cドライブ以外をマウント](https://xn--v6q832hwdkvom.com/post/wsl%E3%81%A7%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF%E3%83%89%E3%83%A9%E3%82%A4%E3%83%96%E3%82%92%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%88%E3%81%99%E3%82%8B/)

    ```bash
    # マウントポイント作成
    $ sudo mkdir /mnt/mount_point
    # マウント
    $ sudo mount -t drvfs /path/to/drive
    # マウント状況確認
    $ mount
    ```

- Windows 上でファイルを開く

    ```bash
    explorer.exe /path/to/file
    ```

- systemctl が使えない → upstart させる

    ```bash
    sudo service docker restart
    ```

## CLion との連携

- ログインシェルは bash のまま (zsh だと make, compilers が認識しない)
  - zsh 等が使いたければターミナルソフト側でシェルを変更して使う
- /etc/wsl.conf を設定 (設定しないと toolchain の cmake エラー)
- GUI 使用
  - DISPLAY 設定をファイルから読み込む。または
  - [login shell を読み込むように設定](https://intellij-support.jetbrains.com/hc/en-us/community/posts/4412179322514-How-to-run-and-debug-a-GUI-application-on-WSL2-)

## Docker

```bash
# サービス開始
sudo service docker start
```

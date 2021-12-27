---
title: WSL メモ
---

## インストール手順

0. [コマンドで有効化](https://docs.microsoft.com/ja-jp/windows/wsl/install-win10), appwiz.cpl (Win+R)
1. WSL1 有効化
    ```shell
    $ dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    ```
2. WSL2 に必要な設定
    ```shell
    $ dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```
3. [Linux カーネルの更新](https://docs.microsoft.com/ja-jp/windows/wsl/wsl2-kernel)
：[コマンドで実施？](https://news.mynavi.jp/article/20200620-1059833/)
4. 再起動して ver. 2 をデフォルトに
    ```shell
    $ wsl --set-default-version 2
    ```
5. 「Ubuntu 18.04」をインストール
6. バージョン確認
    ```shell
    $ wsl -l -v
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

## CLion との連携

- ログインシェルを bash のままにする
    - zsh だと make, compilers が認識しない
- /etc/wsl.conf を設定する
    - 設定しないと toolchain の cmake エラー

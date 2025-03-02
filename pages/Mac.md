---
title: Mac メモ
---
  
## M1 Mac 設定

- [クリーンインストール](https://support.apple.com/ja-jp/guide/mac-help/mchl7676b710/12.0/mac/12.0)：「システム環境設定」＞「すべてのコンテンツと設定を消去」
- [Terminal の Rosetta 解除](https://hkmc.jp/note/mac/not_become_arm64.html)
  - ログインシェルが x86_64 になっていないか？

  ```bash
  brew uninstall zsh
  chsh -s /bin/zsh
  ```

## 開発環境

- [MacからWindowsへRDP接続するとキーボードがJISではなくUS配列になるとき](https://tex2e.github.io/blog/windows/RDP-from-macos#:~:text=Mac%E3%81%AE%E3%80%8CMicrosoft%20Remote%20Desktop,%E4%BA%8B%E8%B1%A1%E3%81%8C%E8%A7%A3%E6%B6%88%E3%81%95%E3%82%8C%E3%81%BE%E3%81%99%E3%80%82)
- [Mac ユーザーのための c++ <bits/stdc++.h> インクルード方法](https://qiita.com/granddaifuku/items/c26b58b89d73b4a3de98)

## iOS アプリ開発

### アプリ認証設定

- [アプリ認証](../images/ios_app_register.png "アプリ認証")
- 設定
  - [Packaging] -> [Product Bundle Identifier] を変更
  - [Signing] -> [Development Team] を変更
- 参考 URL
  - [teratrail: Xcodeで作ったアプリを実機に入れる際のエラー](https://teratail.com/questions/51057)
  - [StackExchange: Xcode Build Error: No account for team “S23Q9DM44M”](https://bit.ly/3hnulr5)

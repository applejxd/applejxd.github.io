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

## iOS アプリ開発

### アプリ認証設定

- [アプリ認証](../images/ios_app_register.png "アプリ認証")
- 設定
  - [Packaging] -> [Product Bundle Identifier] を変更
  - [Signing] -> [Development Team] を変更
- 参考 URL
  - [teratrail: Xcodeで作ったアプリを実機に入れる際のエラー](https://teratail.com/questions/51057)
  - [StackExchange: Xcode Build Error: No account for team “S23Q9DM44M”](https://bit.ly/3hnulr5)
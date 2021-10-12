---
title: Mac メモ
---

## M1 Mac 設定

- [Terminal の Rosetta 解除](https://bit.ly/3iUT5aH)
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
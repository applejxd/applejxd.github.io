---
title: Linux サーバメモ
---

## ユーザー処理

- ユーザー管理
  - ワンライナーで追加：`sudo useradd -m -s /bin/bash username`
    - -m オプション：ホームディレクトリ作成
    - -s オプション：ログインシェル指定
  - ウィザードで追加：`sudo adduser username`
  - ユーザー削除：`sudo userdel -r username`
- グループ管理

  ```bash
  # セカンダリグループに group を追記
  sudo usermod -aG group $USER
  # sudo 権限を追加
  sudo usermod -aG sudo username
  # docker を sudo なしで実行できるようにする
  sudo usermod -aG docker username
  # RDP 接続可能にする
  sudo usermod -aG xrdp username

  # ユーザのグループ確認
  cat /etc/group | grep $USER
  # グループのユーザ確認
  cat /etc/group | grep sudo
  ```

## SMB サーバマウント


  
## モニタリング

- [Linux 負荷監視コマンドまとめ](https://qiita.com/aosho235/items/c4d6995743dd1dac16e1)

```shell
# os 確認
neofetch

# 記憶容量確認 (h オプションで単位を調整)
df -h

# メモリ確認 (h オプションで単位を調整)
free -h
```
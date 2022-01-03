---
title: SSH メモ
---

## SSHサーバ構築

Ubuntu の場合

```bash
sudo apt install -y openssh-server

# パスワード認証許可
sudo sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
# 公開鍵認証有効化
sudo sed -i 's/.*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config 


sudo systemctl restart sshd
```

Windows の場合

```ps1
```

## パスワード認証

## 公開鍵認証

[SSH 鍵生成](https://qiita.com/suzuki-koya/items/af4b511d40b6362da60a):`ssh-keygen -t ed25519 -P "" -f key_name`
- 鍵の方式:`-t ed25519`
- パスワードなし:`-P ""`
- 鍵の名前指定:`-f key-name`

[ホスト側へ鍵登録](https://qiita.com/kazokmr/items/754169cfa996b24fcbf5):`ssh-copy-id -i ~/.ssh/key_name.pub remote_url`
　- 直接行う場合は key-name.pub を登録先の ~/.ssh/authorized_keys に追記

      ```bash
      # クライアント側
      eval `ssh-agent`
      ssh-add ~/.ssh/key_name
      scp key_name.pub remote_url:~/.ssh
      # サーバ側
      cat ~/.ssh/key_name.pub >> ~/.ssh/authorized_keys
      ```

権限の設定。
設定がシビアなのでシンボリックリンクは厳禁(あるいは要注意)。

```bash
sudo chmod 755 $HOME
sudo chmod 755 ~/.ssh
sudo chmod 600 ~/.ssh/*
```

## 多段 SSH

      
## ポートフォワーディング


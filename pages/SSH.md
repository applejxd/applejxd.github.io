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

# 再起動
sudo systemctl restart sshd
```

Windows の場合

```ps1
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

## パスワード認証

## 公開鍵認証

[SSH 鍵生成](https://qiita.com/suzuki-koya/items/af4b511d40b6362da60a): `ssh-keygen -t ed25519 -P "" -f key_name`

- 鍵の方式:`-t ed25519`
- パスワードなし:`-P ""`
- 鍵の名前指定:`-f key-name`

[ホスト側へ鍵登録](https://qiita.com/ir-yk/items/af8550fea92b5c5f7fca): 以下のどれかで登録

```bash
# 1. 専用コマンドで登録
ssh-copy-id -i ~/.ssh/key.pub host_address

# 2. ホスト側でコマンド実行 (authorized_keys へ一発書込)
cat ~/.ssh/key.pub | ssh host_address 'cat >> ~/.ssh/authorized_keys'

# 3. scp で公開鍵を送信
scp ~/.ssh/key.pub host_address:~/.ssh
ssh host_address
cat ~/.ssh/key.pub >> ~/.ssh/authorized_keys
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


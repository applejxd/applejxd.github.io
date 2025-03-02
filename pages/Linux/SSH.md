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

[Windows の場合](https://docs.microsoft.com/ja-jp/windows-server/administration/openssh/openssh_install_firstuse)

```bash
# sshd 起動
Start-Service sshd
```

## SSH クライアント設定

[.ssh/config の設定](https://koejima.com/archives/583/)。
ワイルドカードを使って基本設定をする。

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

[ProxyCommand の設定方法](https://dev.classmethod.jp/articles/bastion-multi-stage-ssh-only-local-pem/)

```bash
Host bastion
  HostName 192.168.x.x
  Port 22
  User bation_user
  # ローカル端末に保存した、踏み台サーバの秘密鍵のパス指定
  IdentityFile ~/.ssh/bation_key

Host private
  HostName 192.168.y.y
  Port 22
  User private_user
  # ローカル端末に保存した、プライベートサーバの秘密鍵のパス指定
  IdentityFile ~/.ssh/private_key
  # 踏み台サーバを経由してログイン
  ProxyCommand ssh bastion -W %h:%p

Host docker
  HostName localhost
  Port 2222
  User private_user
  IdentityFile ~/.ssh/docker_key
  ProxyCommand ssh bastion -W %h:%p
```

## ポートフォワーディング

Windows での設定

1. [ポート解放](https://qiita.com/taro0219/items/cac50f7bec48c7f5cc6d)
2. [FW 設定](https://kagasu.hatenablog.com/entry/2018/01/29/184205)

```ps1
# ポート解放
netsh advfirewall firewall add rule name="sshd" dir=in action=allow protocol=TCP localport=2222 profile=private

# ファイアウォール確認
netsh advfirewall firewall show rule name="sshd"

# FW 設定追加
netsh interface portproxy add v4tov4 listenport=2222 connectport=22 connectaddress=192.168.0.20

# FW 設定確認
netsh interface portproxy show all

# FE 設定削除
netsh interface portproxy delete v4tov4 listenport=2222
```

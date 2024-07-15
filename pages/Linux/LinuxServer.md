---
title: Linux サーバメモ
---

## モニタリング

- [Linux 負荷監視コマンドまとめ](https://qiita.com/aosho235/items/c4d6995743dd1dac16e1)

```shell
# os 確認
neofetch
# ディスク記憶容量確認 (h オプションで単位を調整)
df -h
# フォルダ記憶容量確認
du -sh ./*
# メモリ確認 (h オプションで単位を調整)
free -h
# CPU 温度
vcgencmd measure_temp
# 1 秒毎に確認
watch -n 1 free -h
# 処理の優先順位を下げて実行
nice watch -n 1 free -h
```

## ログ確認

- システム全体：/var/log/syslog

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

## ネットワーク設定

- 固定 IP などの設定は [netplan](https://www.komee.org/entry/2018/06/12/181400) で
  - Ubuntu の旧方式は /etc/network/interfaces て設定していた
  - [ユーザ設定は /etc/netplan/99-manual.yaml に](https://qiita.com/yas-nyan/items/9033fb1d1037dcf9dba5)
  - 更新処理は `sudo netplan apply`
- NIC へ IPv4 アドレスの自動割当（DHCPv4 クライアント有効化）は `sudo dhclient hoge` で

## NAS マウント

自動でマウントする場合は /etc/fstab に設定を記載。
(cf. [起動時にCIFS自動マウント](http://www.profaim.jp/tools/soft/linux/auto_mnt.php))

```bash
# for mount.cifs
sudo apt-get install -y cifs-utils

# mode 指定はファイルの書込み等のために必要. vers は SMB 2.0 に対して必要.
sudo mount -t cifs //nas_ip/hoge $HOME/mnt/hoge -o username=fuga,password=piyo,file_mode=0777,dir_mode=0777,vers=2.0
```

## dd コマンド (ディスク読み書き)

Windows は以下で使用可能:

```bash
scoop install dd
```

コマンド例:

```bash
# メディア確認
dd --list
# 書き出し, bs は一度に書き込みするサイズ
dd if=$(メディア名) of=$(出力先).iso bs=1M
# 書き込み
dd if=$(対象ファイル).iso of=$(メディア名) bs=1M
```

## service 登録

- [systemdによるサービス作成（Ubuntu起動時処理）](https://qiita.com/bd8z/items/35c2b059819fd64e44b3)

`/etc/systemd/system/my_server.service` に次。

```ini
[Unit]
Description=my server
After=network.target

[Service]
User=ubuntu
ExecStart=/bin/bash /home/ubuntu/start.sh
Restart=no
Type=simple

[Install]
WantedBy=multi-user.target
```

有効化。

```bash
sudo systemctl daemon-reload
sudo systemctl start my_server
sudo systemctl status my_server.service
```
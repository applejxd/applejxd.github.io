---
title: Ubuntu メモ
---


## Raspberry Pi

[ラズパイで Ubuntu Server](https://zenn.dev/spacelogic/articles/5901557b0e010b)

- [事前構築済みイメージ](https://ubuntu.com/download/raspberry-pi)
- [cloud-init 設定(user-data)](https://aquasoftware.net/blog/?p=2039)

```bash
xzcat ./ubuntu-24.04.1-preinstalled-server-arm64+raspi.img.xz | sudo dd of=/dev/sda bs=32M status=progress; sync
```

## 日本(語)設定

[apt のミラー設定](https://aquasoftware.net/blog/?p=2039)

```bash
# 24.04 以降
sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list.d/ubuntu.sources
# 24.04 未満
sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list
```

- [fcitx5-mozc](https://widedeepspace.net/2024/05/12/1529/)
  1. `sudo apt install -y fcitx5-mozc`
  2. 「言語サポート」を Fcitx5 に
  3. 「Fcitx の設定」を Mozc のみに
  4. 「Fcitx の設定」入力メソッドの切替関係を「空」に
  5. Mozc の初期モードを「直接入力に」
  6. Mozc の設定ツールから Eisu の項目全てを「IMEをOFF」に・Hiragana の項目全てを「IMEをON」に 
- [英数・かな設定](https://namileriblog.com/linux/ubuntu22-10_keyboard_setting/)
  - 文字コードは `xev` から確認可能
    
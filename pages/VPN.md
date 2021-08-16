---
title: VPN 設定メモ
---

## 目標

集合住宅タイプのインターネット契約でグローバルIPの割当がない状況で、
自宅のネットワークを利用する。

## 構成

- VPN 設定に SoftEther VPN を利用
- VPN サーバとなる VPS サーバ（AWS Lightsail など）
- VPN ブリッジとなる自宅内サーバ
- VPN クライアントは L2TP で接続

## 手順

1. ネットワーク設計を行う・IP アドレスの割当決定（[設計例](https://dsp74118.blogspot.com/2016/02/vpssoftether-vpnlan.html)）
2. VPS サーバ立ち上げ（[AWS Lightsail を使う場合](https://www.episode02.com/entry/2018/10/03/230945)）
    - 静的 IP の割当を実施
    - TCP ポート 443, UDP ポート 500・4500 開放
3. VPS サーバに SoftEther VPN Server をインストール（[インストールスクリプト](https://github.com/applejxd/softether-setup)）
4. 自宅内サーバに SoftEther VPN Bridge・Server Manager をインストール（[ダウンロードリンク](https://www.softether-download.com/ja.aspx?product=softether)）
5. Server Manager から VPS サーバを設定
    - 仮想 HUB 作成 → ブリッジ用とクライアント用で別々のユーザを作成 → SecureNat 有効化（1. で設計したアドレスを指定）
    - IPsec/L2TP 設定（セキュリティのため必ず事前共有キーは変更）
    - ローカルブリッジ設定（「新しい tap デバイスとのブリッジ接続」）
6. Server Manager から 自宅サーバ（localhost） を設定
    - 仮想 HUB 作成 → カスケード接続設定
    - ローカルブリッジ設定
7. 自宅内ネットワークのルータの設定変更
    - 上記 1. に応じてルータのアドレスとDHCPの設定変更
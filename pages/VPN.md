---
title: VPN 設定メモ
---

## 目標

(「集合住宅タイプのインターネット契約」や WiMAX 利用など)
グローバルIPの割当がない状況で自宅のネットワークを利用する。

## 構成

- VPN サーバとなる VPS サーバ（AWS Lightsail など）
    - SoftEther VPN Server 利用
- VPN のブリッジ用自宅サーバ (Raspberry Pi や Windows PC など)
    - SoftEther VPN Server または SoftEther VPN Bridge を使用
    - [VPN Bridge は VPN Server の機能制限版。](https://ja.softether.org/4-docs/1-manual/5/5.3_Differences_between_VPN_Server_and_VPN_Bridge)
      VPN Bridge はブリッジ拠点構成の最小版で、VPN Server と接続する単一の仮想HUBとローカルブリッジ機能を持つ。
- VPN クライアントは L2TP で接続
- リモートサーバの SoftEther VPN の設定はローカルの SoftEther VPN Server Manager で実施

## 手順

1. ネットワーク設計を行う・LAN IP アドレスの割当決定（[設計例](https://dsp74118.blogspot.com/2016/02/vpssoftether-vpnlan.html)）
    - ゲートウェイの IP アドレス
    - VPN サーバの IP アドレス (Secure NAT の仮想 NIC)
    - VPN ブリッジ用サーバの IP アドレス
3. VPS サーバ構築（[AWS Lightsail を使う場合](https://www.episode02.com/entry/2018/10/03/230945)）
    - 静的 IP の割当を実施
    - TCP ポート 443, UDP ポート 500・4500 開放
    - [SoftEther VPN Server 構築スクリプト](https://github.com/applejxd/softether-setup)
4. VPN ブリッジ用自宅サーバ構築
    - [SoftEther VPN Server 構築スクリプト](https://github.com/applejxd/softether-setup)
6. 自宅 PC に[SoftEther VPN Server Manager](https://www.softether-download.com/ja.aspx?product=softether)をインストール
7. VPN サーバ設定 (from Server Manager)
    - 仮想 HUB 作成 → ブリッジ用とクライアント用で別々のユーザを作成 → SecureNat 有効化（1. で設計したアドレスを指定）
    - 上記仮想 HUB に VPN クライアントと VPN ブリッジ用サーバのユーザを作成 (VPN ブリッジ用サーバは固有証明書認証を推奨)
    - IPsec/L2TP 設定（セキュリティのため必ず事前共有キーは変更）
    - ローカルブリッジ設定（「新しい tap デバイスとのブリッジ接続」）
8. VPN ブリッジ用サーバを設定 (from Server Manager)
    - 仮想 HUB 作成 → カスケード接続設定 (ホスト名：静的IP, ポート番号:5555, ユーザ認証：クライアント証明書認証)
    - ローカルブリッジ設定 (LANカードへブリッジするため有線接続必須)
9. 自宅内ネットワークのルータの設定変更
    - 上記 1. に応じてルータのアドレスとDHCPの設定変更

## その他参考リンク

### 設定参考
- [ネットワーク構成例](http://gachi3lab.blogspot.com/2017/09/vpsvpn.html)
- [Ubuntu への SoftEther VPN インストール](https://qiita.com/rimksky/items/e169f9af83ce472b4ce3)
- [ポート開放の詳細](http://www.ranran.mydns.jp/blog/?p=195)
- [ppa から SoftEther VPN インストール](https://zenn.dev/nemuki/articles/aa5b93e506f765)：バグのためVPN接続がうまくいかない？

### シンプルな VPN 設定
- [IPsec VPN Server Auto Setup Scripts](https://github.com/hwdsl2/setup-ipsec-vpn)
- [上記を使ったシンプルな VPN サーバ設定例](https://engineers.weddingpark.co.jp/aws-cli-amazon-lightsail/)

### リモートデスクトップ
- [Windows 10 HomeをProにアップグレードしたら何故かEnterpriseになってライセンス認証が通らない](https://www.nedia.ne.jp/blog/tech/2019/06/11/14605)
- [Windows 10 の汎用プロダクトキー一覧](https://chirashi.twittospia.com/%E6%8A%80%E8%A1%93/windows-10%E3%81%AE%E6%B1%8E%E7%94%A8%E3%83%97%E3%83%AD%E3%83%80%E3%82%AF%E3%83%88%E3%82%AD%E3%83%BC%E3%81%A8%E3%81%AF%E4%BD%95%E3%81%A7%E3%81%99%E3%81%8B%EF%BC%9F%E3%81%9D%E3%82%8C%E3%82%89%E3%82%92/2020-10-18/)

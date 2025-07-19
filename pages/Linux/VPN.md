---
title: VPN 設定メモ
---

## VPN の目的

VPN（Virtual Private Network）は、インターネット越しに
プライベートネットワークへ安全に接続するための技術。
通信は暗号化され、遠隔地からでもホームネットワークなどにアクセス可能。

動的IPやNAT（Network Address Translation）環境
（例：集合住宅のインターネット契約、WiMAX など）では
外部からの直接接続ができない場合が多いが、
VPNを使えば中継サーバやNAT越え技術を通じて自宅ネットワークにアクセス可能。

そもそもパブリックIPを直接端末に持たせて接続を受ける方法は
セキュリティリスクが高く、公開サーバ等の目的がなければ避けるべき。

## 構築の選択肢（外部からホームネットワークを利用する場合）

- **L3 接続（IP-VPN）の場合**  
  対応ソフトウェアが多く、構成も比較的シンプルで、**手軽かつ汎用的に使えるのが利点**。  
  外部端末には自宅とは別のサブネットが割り当てられ、IPルーティングによってホームネットワークと通信する。  
  IPアドレスやホスト名を指定して、SSH、SMB、HTTP、RDP などの**明示的な通信が可能**。  
  ただし mDNS、DLNA、NASの自動検出、プリンタ共有など、**L2ブロードキャストを必要とするサービスは非対応**。  
  通信は基本的にユニキャストのみで、**余分なブロードキャストが流れず通信量は少なめ**。  
  主な実装例：Tailscale、WireGuard、OpenVPN、IPsec など。

- **L2 接続（広域イーサネット型）の場合**  
  外部端末を自宅LANと**同一セグメントに接続できる点が最大の利点**。  
  仮想的にレイヤ2ブリッジを構成し、同じネットワークに属しているかのように振る舞う。  
  DHCP、Bonjour、mDNS、WOL、NAS自動検出、プリンタ共有など、**家庭内LAN特有の通信がそのまま使える**。  
  一方で構築の難易度は高く、**L2ブリッジや仮想スイッチの設定が必要**になることもある。  
  ブロードキャストやマルチキャストもすべて通るため、**アイドル時でも一定量の通信が常時発生しやすい**。  
  主な実装例：SoftEther VPN（L2モード）、WireGuard + VXLAN、OpenVPN + tap デバイスなど。

## L3 接続（IP-VPN）の場合

Tailscale ならサービスにログインしてガイドに従えば設定できる。

## L2 接続（広域イーサネット）の場合

以下のように構築：

1. 静的グローバル IP か DDNS サービスに対応した環境を用意
   - 静的グローバル IP は「さくらのVPS」や「AWS Lightsail」などで対応環境が用意可能
   - DDNS サービスは TP-Link のルータなどで利用可能（固定のドメインとグローバルIPを自動対応）
2. 対象の環境と 1. の環境を VPN で L2 接続
3. 接続クライアントは 1. の環境へ VPN 接続・経由して対象環境へアクセス

IPアドレスは国ごとにレンジが決まっていることに注意。
[「IPアドレスの割り当て国検索」](https://testpage.jp/tool/ip_address_country.php)から検索可能。
各種 Web サイトへのアクセスは（サーバの設置国に関わらず）IPアドレスの割り当て国で判定されることに注意。
(AWS に割り当てられる IP アドレスは全て US 判定？)

## OpenVPN

### 使用方法

TP-Link ルータ & Ubuntu クライアントの場合は次の通り：

1. TP-Link の設定画面から ovpn ファイルを出力
   - 手順は 「詳細設定」→「VPN サーバ」→「OpenVPN」→「設定ファイル」→「出力」
2. 必要であれば OneDrive などのクラウドストレージに一時保存
   - Ubuntu 側での設定ファイルダウンロードに使う
3. Ubuntu の設定で ovpn ファイル読み込み
   - 手順は「ネットワーク」 →「VPN」→ 「+」ボタン押下→「ファイルからインポート」→ ovpn ファイルを選択
4. クラウドに保存していた設定はセキュリティ強化のため削除する

## SoftEther VPN

## 設定新規構成

### やる事

[「Softether VPN §10.5 拠点間接続 VPN の構築」](https://ja.softether.org/4-docs/1-manual/A/10.5)
の通り

1. カスケード接続でリモートの仮想 HUB 同士を Ethernet レベル (L2) 接続
2. ローカルブリッジ接続で物理 LAN カードと仮想 HUB を Ethernet レベル (L2) 接続

### 構成

- VPN サーバとなる VPS サーバ（「AWS Lightsail」や「さくらのVPS」など）
  - SoftEther VPN Server 利用
  - [VPSの比較](https://qiita.com/sakarush/items/554dcf920585a8480542)
- VPN のブリッジ用自宅サーバ (Raspberry Pi や Windows PC など)
  - SoftEther VPN Server または SoftEther VPN Bridge を使用
  - [VPN Bridge は VPN Server の機能制限版。](https://ja.softether.org/4-docs/1-manual/5/5.3_Differences_between_VPN_Server_and_VPN_Bridge)
      VPN Bridge はブリッジ拠点構成の最小版で、VPN Server と接続する単一の仮想HUBとローカルブリッジ機能を持つ。
- VPN クライアント (L2TP で接続)
- SoftEther VPN Server Manager 用ローカル PC

### 手順

1. ネットワーク設計を行う・LAN IP アドレスの割当決定（[設計例](https://dsp74118.blogspot.com/2016/02/vpssoftether-vpnlan.html)）
    - 家庭 LAN 環境のゲートウェイの IP アドレス
    - VPN サーバの IP アドレス (Secure NAT の仮想 NIC)
    → 「仮想 DHCP サーバのデフォルトゲートウェイ」「DNS サーバ」の IP アドレス
    - VPN ブリッジ用サーバの IP アドレス
2. VPS サーバ構築（[AWS Lightsail を使う場合](https://www.episode02.com/entry/2018/10/03/230945)）
    - 静的 IP の割当を実施
    - TCP ポート 443, UDP ポート 500・4500 開放
    - [SoftEther VPN Server 構築スクリプト](https://github.com/applejxd/softether-setup)
3. VPN ブリッジ用自宅サーバ構築
    - [SoftEther VPN Server 構築スクリプト](https://github.com/applejxd/softether-setup)
4. 自宅 PC に[SoftEther VPN Server Manager](https://www.softether-download.com/ja.aspx?product=softether)をインストール
5. VPN サーバ設定 (from Server Manager)
    - 仮想 HUB 作成 → ブリッジ用とクライアント用で別々のユーザを作成 → SecureNat 有効化（1. で設計したアドレスを指定）
    - 上記仮想 HUB に VPN クライアントと VPN ブリッジ用サーバのユーザを作成
    (VPN ブリッジ用サーバは固有証明書認証を推奨)
    - IPsec/L2TP 設定（セキュリティのため必ず事前共有キーは変更）
    - ローカルブリッジ設定（「新しい tap デバイスとのブリッジ接続」）
6. VPN ブリッジ用サーバを設定 (from Server Manager)
    - 仮想 HUB 作成 → カスケード接続設定 (ホスト名：静的IP, ポート番号:5555, ユーザ認証：クライアント証明書認証)
    - ローカルブリッジ設定 (LANカードへブリッジするため有線接続必須)
7. 自宅内ネットワークのルータの設定変更
    - 上記 1. に応じてルータのアドレスとDHCPの設定変更

## 設定移行

- [【SoftEther VPN】サーバーのバックアップを取得する方法](https://office54.net/iot/app/softether-vpn-backup)
  - 「管理画面」→「Config 編集」から操作
  - エクスポートは「ファイルに保存」。インポートは「ファイルからインポートして書き込む」。
  - クライアント情報・ログイン情報なども引き継がれる

### Linux の VPN サーバの注意

[「Softether VPN §3.6 ローカルブリッジ」](https://ja.softether.org/4-docs/1-manual/3/3.6)によると

> Linux オペレーティングシステム内部での制限事項により、VPN 側 (仮想 HUB 側) からローカルブリッジしている LAN カードに割り当てられる IP アドレスに対して通信を行うことはできません。

とある。つまり単純に Linux PC で VPN サーバを稼働すると SSH や HTTP などで接続することができない。その対策として

> ローカルブリッジ用の LAN カードを用意して接続し、その LAN カードと既存の LAN カードの両方を物理的に同じセグメントに接続してください

といったことが必要になる。
つまり通常の SSH や HTTP などの通信を行う既存の物理 LAN カードに加えて、VPN を用いた拠点間通信用の仮想 (または物理) LAN カードを用意しなければならない。
この LAN カードの用意は tap デバイスの追加で解決できる。tap デバイスは

 > Linux 版 VPN Server / VPN Bridge を使用している場合は、ローカルブリッジ先のネットワークデバイスとして、既存の物理的な LAN カードを指定するのではなく、新しい「tap デバイス」を作成して、その tap デバイスに対してブリッジ処理を行うことが可能です。(中略)この機能によって生成された tap デバイスは、仮想 HUB に直接接続した仮想 LAN カードのように振舞います。

とある ように Linux 版 Softether で使用可能な仮想 LAN カードとして扱える。
tap デバイスも netplan の ethernets の一つとして固定 IP を割り振ることが可能で、tap デバイスを介して SSH や HTTP 等での接続が可能。

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

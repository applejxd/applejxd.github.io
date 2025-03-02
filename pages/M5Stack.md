---
layout: top
title: M5Stack メモ
---


## M5Stack メモ

### VSCode (Platform IO) 環境構築

参考: [M5Stackの開発環境を整える - PlatformIO IDE編](https://qiita.com/lutecia16v/items/1c560bdd7eac7ebeaff7)

1. VSCode インストール
2. 拡張機能空 Platform IO インストール
3. Platform IO の Libraries から必要なライブラリをインストール
   - 基本的には M5Stack.h をインストール
   - M5Unified.h を使う場合は M5Stack.h をアンインストール (競合するため)

### Arduino IDE 環境構築

1. [ドライバーインストール](https://github.com/m5stack/M5Atom)
   1. [FTDI ドライバー](https://ftdichip.com/drivers/vcp-drivers/)ダウンロード & 解凍
   2. [ドライバーマネージャーからインストール](https://docs.m5stack.com/en/quick_start/atom/arduino)
2. Arduino IDE インストール `winget install 9NBLGGH4RSD8`
3. [Arduino IDE 設定](https://docs.m5stack.com/en/quick_start/atom/arduino)
   1. 「ファイル」>「環境設定」>「追加のボードマネージャのURL」を設定
   2. 「ツール」>「ボード:~」>「ボードマネージャ」>「M5Atom」検索 & インストール
   3. 「ツール」>「ボード:~」>「M5Stack Arduino」>「M5Stick-C」
   4. 「ツール」>「シリアルポート」>デバイスマネージャの「ポート(COM と LPT)」で確認した COM ID

### ハードウェア制御

- [シリアル通信の文字化け解消方法](https://qiita.com/Rcobb/items/20ee2a0613d081295327)
  - setup() 関数で Serial.begin(19200) のように通信速度を設定
  - platformio.ini で monitor_speed を同じ速度に設定
- [ドットマトリクスLED簡単制御方法](https://logikara.blog/matrix_matrix/)
  - M5.dis.drawpix メソッドで表示変更
    - 第1引数は LED の位置。左上から右下へ順に 0~5x5 の整数(下は端子のある側)。
    - 第2引数は光らせる色。255 階調 の 16 進数。0xrrggbb。
  - ボタン押下時は M5.Btn.wasPressed() が true となる

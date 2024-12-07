---
title: WSL メモ
---

## 設定書き込み

- [Keychron Launcher](https://launcher.keychron.com/#/keymap)
- [ファームウェア書き込み方法](https://keychron.co.jp/pages/how-to-factory-reset-or-use-the-launcher-web-app-to-flash-firmware-for-your-keyboard)
  - [QMK Toolbox](https://github.com/qmk/qmk_toolbox/releases)

## QMK ファームウェア

- [QMK OSS](https://github.com/qmk/qmk_firmware)
  - [ビルドには QMK MSYS を使う](https://docs.qmk.fm/newbs_getting_started)
  - [JIS 配列定義](https://github.com/qmk/qmk_firmware/tree/master/layouts/default/60_jis)
- [Keychron の fork](https://github.com/Keychron/qmk_firmware)
  - [WiFi 接続モデル向けブランチ(wireless_playground)](https://github.com/Keychron/qmk_firmware/tree/wireless_playground/keyboards/keychron)
- [Keychron によるファームウェア配布](https://www.keychron.com/pages/firmware-and-json-files-of-the-keychron-qmk-keyboards)

[Keychron Q1 Max](https://keychron.co.jp/products/keychron-q1-qmk-custom-mechanical-keyboard-japan-jis-layout) では次のように記載：

> Q1 Japan JIS KnobバージョンのVIAコードは、まだGithubからの承認を待っているため、まだ自動的に認識されていません。
> 以下の適切なキーマップJSONファイル（ANSIまたはISO）をダウンロードし、VIAを開き、[設定]タブの[デザインタブの表示]をオンにし、JSONファイルをVIAの[デザイン]タブにドラッグして、Q1ノブキーマップを機能させます。

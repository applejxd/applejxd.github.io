---
title: WSL メモ
---

## 設定書き込み

- [Keychron Launcher](https://launcher.keychron.com/#/keymap)
- [ファームウェア書き込み方法](https://keychron.co.jp/pages/how-to-factory-reset-or-use-the-launcher-web-app-to-flash-firmware-for-your-keyboard)
  - [QMK Toolbox](https://github.com/qmk/qmk_toolbox/releases)

## QMK ファームウェア

- キーボードレイアウト
  - [設定作成方法](https://zenn.dev/74th/articles/7efc788a31d06f#3.-keyboard-layout-editor%E3%81%A7%E3%83%AC%E3%82%A4%E3%82%A2%E3%82%A6%E3%83%88%E3%82%92%E5%86%8D%E7%8F%BE%E3%81%99%E3%82%8B)
  - [Keyboard Layout Editor](https://www.keyboard-layout-editor.com/#/)
  - [KLE -> QMK info.json Converter](https://qmk.fm/converter/)
- [QMK OSS](https://github.com/qmk/qmk_firmware)
  - [ビルドには QMK MSYS を使う](https://docs.qmk.fm/newbs_getting_started)
  - [JIS 配列定義](https://github.com/qmk/qmk_firmware/tree/master/layouts/default/60_jis)
- [Keychron の fork](https://github.com/Keychron/qmk_firmware)
  - [WiFi 接続モデル向けブランチ(wireless_playground)](https://github.com/Keychron/qmk_firmware/tree/wireless_playground/keyboards/keychron)
- [Keychron によるファームウェア配布](https://www.keychron.com/pages/firmware-and-json-files-of-the-keychron-qmk-keyboards)

[Keychron Q1 Max](https://keychron.co.jp/products/keychron-q1-qmk-custom-mechanical-keyboard-japan-jis-layout) では次のように記載：

> Q1 Japan JIS KnobバージョンのVIAコードは、まだGithubからの承認を待っているため、まだ自動的に認識されていません。
> 以下の適切なキーマップJSONファイル（ANSIまたはISO）をダウンロードし、VIAを開き、[設定]タブの[デザインタブの表示]をオンにし、JSONファイルをVIAの[デザイン]タブにドラッグして、Q1ノブキーマップを機能させます。

## Q6 Max JIS ファームウェアの作り方

1. [Keyboard Layout Editor](https://www.keyboard-layout-editor.com/#/) でレイアウト作成
   - ただし 列は 0~19 に必ず収める。最後の列は `3,13`, `3,14`, ... と3行目の余りのキーを付与。
   - [公式の json](https://www.keychron.com/pages/firmware-and-json-files-of-the-keychron-qmk-keyboards) から配置が読み取れる
   - `Raw data` から `Download JSON` で保存
   - 別途 `Raw data` の内容をクリップボードにコピー
2. [KLE -> QMK info.json Converter](https://qmk.fm/converter/) でフォーマット変換
   - 1. の手順でコピーした内容を貼り付け
   - 結果を `info_pre.json` として保存
3. Python スクリプトで更に変換

    ```python
    import json
    import sys

    # path = sys.argv[1]
    path = r"C:\Users\applejxd\Desktop\info_pre.json"

    with open(path) as f:
        d = json.load(f)

    layout = d["layouts"]["LAYOUT"]["layout"]

    for i in range(len(layout)):
        pos = layout[i]["label"].split(',')
        layout[i]["matrix"] = [int(num) for num in pos]

    with open('./info.json', 'w') as f:
        json.dump(d, f, indent=2)
    ```

4. [Keychron の fork](https://github.com/Keychron/qmk_firmware) を clone
   - ホームフォルダの直下に clone
5. [WiFi 接続モデル向けブランチ(wireless_playground)](https://github.com/Keychron/qmk_firmware/tree/wireless_playground/keyboards/keychron) を checkout
6. `keyboards/keychron/q6_max` を参照
7. `ansi_encoder` をコピーして `jis_encoder` と名称変更
8. `jis_encoder/info.json` の `layouts` に `LAYOUT_112_jis` として 3. の出力結果をペースト
9. `jis_encoder/config.h` に `#define DYNAMIC_KEYMAP_LAYER_COUNT 6` などと追記してレイヤー数を増加
10. `jis_encoder/keymaps/via/keymap.c` の配列を `LAYOUT_112_jis` に変更。
    - キーの順番は info.json の順番
    - (キーマップは `keyboards/keychron/k10_pro` などの 100% JIS キーボードからコピーしてくる)
    - メディアキーは Q6 Max では未定義のため `KC_ESC, KC_F1, ...` をコピー・貼り付けして上書き
11. `keymap.c` のレイヤ数をコピペで増やす
    - `layers` 列挙体に `FN_CX, FN_M` などとして新規レイヤーの名前を作成
    - 同様の名前で `keymaps` の内容もコピペで増やす
    - `encoder_map` についても同様
12. QMK MSYS でビルド: `qmk compile -kb keychron/q6_max/jis_encoder -km via`
    - VIA 機能を有効化するためには `rules.mk` に記載のある `via` をビルド
13. QMK Toolkit で出来上がったファームウェアを書き込み
    - ファームウェア書き込みモードは `ESC` を押しながら有線接続
    - ビルドしたファームウェアは `qmk_firmware` フォルダ直下の bin ファイル
    - `Flush` で書き込み
14. [Keychron Launcher](https://launcher.keychron.com/#/keymap) でキーマップ修正
15. [Keychron によるファームウェア配布](https://www.keychron.com/pages/firmware-and-json-files-of-the-keychron-qmk-keyboards) から適切な JSON ファイルを取得
16. キーマップのインポートから上記読み込み JSON を

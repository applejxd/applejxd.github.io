---
title: Windows メモ
---

[WSL はこちら](pages/WSL.html)

## 設定

### セットアップ

1. アカウント作成時はローカルアカウント → Microsoft アカウントに変更 （アカウント名のため）
2. Windows Update & セキュリティ設定
3. バックアップのリストア → tools の設定
4. [セットアップスクリプト](https://github.com/applejxd/windows-setup)

### JetBrain IDEs

- インストール：JetBrains Toolbox から
- PyCharm インタプリタ：Anaconda のルートから python.exe を指定
- CLion ツールチェイン
  - Cygwin：Chocolatey　で可。C:\tools\cygwin を指定。

## Tips

### [ファイル名を指定して実行（Win+R）](http://www.checkpad.jp/list/show/981136)

- システム系
  - タスクマネージャ：taskmgr
  - コマンドプロンプト：cmd
- 設定系
  - コントロールパネル：control
    - プログラムの追加と削除：appwiz.cpl
  - システム構成：msconfig
  - システム情報：msinfo32
    - バージョン情報：winver
- フォルダ系
  - ユーダ（プロファイル）フォルダ：%userprofile%
- ショートカット配置系
  - スタートメニュー：shell:(common) programs
    - スタートアップ：shell:(common) startup
  - 「送る」メニュー：shell:sendto

## トラブルシューティング

### ツール

- セーフモード
    1. Win+R から msconfig
    2. 「ブート」を選択
    3. 「セーフブート」にチェック
- [システムファイルチェッカーツール（SFC.exe）](https://docs.microsoft.com/ja-jp/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference)
- [Windows 回復環境 (Windows RE)](https://docs.microsoft.com/ja-jp/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference)
  - [スタートアップ修復（MBR 修復）](https://support.microsoft.com/ja-jp/help/927392/use-bootrec-exe-in-the-windows-re-to-troubleshoot-startup-issues)
- [工場出荷状態に戻す（HP)](https://support.hp.com/jp-ja/document/c02159559)
：起動時にF11キー
- [クリーンインストールする](https://www.ikt-s.com/windows10_clean_install_fmvd77j/)

### 解決済みの問題

- winget でのインストール失敗
  - 管理者権限での実行(あるいはsudo)が必要
  - エラコード2はインストーラは起動するが途中で失敗するケース → `sudo winget install --interactive` で原因を探る
- [ユーザーフォルダ名の変更](https://pc-karuma.net/windows10-rename-user-folder/)
    1. 作成時はローカルアカウント
    2. Microsoft アカウントに変更
- [顔認証が登録できない](https://answers.microsoft.com/ja-jp/windows/forum/windows_10-hello/windows/3bbfbc43-9099-403a-a92e-a6994a914c10)

 1. PIN, 顔認証を削除
 2. 「タスクマネージャ」から「サービスホスト: Windows Biometric Service」を強制終了
 3. C:\Windows\System32\WinBioDatabase 内のファイルを削除して再起動

- メモ帳がない：「設定→アプリ→オプション機能」でインストール
- KeySwapがうまく作動しない ：設定クリアして再起動・設定して再起動
- WSL の環境をリセットしたい ： 「アプリと機能」から Ubuntu をリセットするだけ

### (個人的)未解決の不具合

- 復元の失敗 → ユーザーアカウント制御が異常に厳しくなる
- 設定のアイコンがうまく表示されない
  - [キャッシュのクリア](https://superuser.com/questions/499078/refresh-icon-cache-without-rebooting)
  - 表示スケールが 100% or 150% (or デフォルト175%) なら起きない
- Hyper terminal のクリアがうまくいかない → バグらしい（Github の Issue に報告されていた）
- Scoop の VSCode が WSL で開けない → Chocolatey なら OK

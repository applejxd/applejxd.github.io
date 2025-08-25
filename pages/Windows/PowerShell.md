---
title: PowerShell メモ
---

## [実行ポリシー](https://qiita.com/kikuchi/items/59f219eae2a172880ba6)

```powershell
# 何らかのスクリプトが実行できなかった場合のコマンド
Set-ExecutionPolicy Unrestricted -Force
# プロセス限定
Set-ExecutionPolicy Bypass -Scope Process -Force 
```

- `Set-ExecutionPolicy`：実行ポリシーを変更
  - `Restricted`：デフォルト。構成ファイルの読み込み・スクリプトの実行を行わない
  - `Unrestricted`：すべての構成ファイルの読み込み・スクリプトの実行が可能。署名なしのスクリプトは確認を行う。
  - `Bypass`：何もブロックせず、警告・メッセージを非表示
- `-Scope Process`：プロセス限定で実行ポリシーを変更（管理者権限は不要）

## ダウンロード

### .Net の WebClient を使う方法

```powershell
(New-Object System.Net.WebClient).DownloadFile('URL','/path/to/save/dir')
(new-object net.webclient).DownloadString('URL')
```

- New-Object：.NET Frameworkのインスタンスを作成
- [`System.Net.Webclient`](https://docs.microsoft.com/ja-jp/dotnet/api/system.net.webclient?view=net-5.0)
  ：データ送受信のためのクラス
  - [`DownloadFile`](https://docs.microsoft.com/ja-jp/dotnet/api/system.net.webclient.downloadfile?view=net-5.0)
  ：データをファイルとしてダウンロードするメソッド
  - [`DownloadString`](https://docs.microsoft.com/ja-jp/dotnet/api/system.net.webclient.downloadstring?view=net-5.0)
  ：データを String としてダウンロードするメソッド

### [その他](https://www.haruru29.net/blog/how-to-download-files-using-powershell/)

- Invoke-WebRequest/iwr (alias として wget)
- curl (Windows 10 1803 以降)

### コマンド実行

- Invoke-Expression/iex：引数の文字列をコマンドとして実行

  ```powershell
  iex ((new-object net.webclient).DownloadString('URL'))
  ```

- Invoke-Command/icm：ローカルおよびリモートコンピュータでコマンドを実行

---
title: PowerShell メモ
---

## 実行ポリシー


## ダウンロード

### WebClient を使う方法

```powershell
(New-Object System.Net.WebClient).DownloadFile('URL','/path/to/save/dir')
```
- New-Object：.NET Frameworkのインスタンスを作成
- System.Net.Webclient：リモートリソースとのデータ送受信に使用
- DownloadFile：コンテンツをダウンロード

```powershell
(new-object net.webclient).DownloadString('URL')
```
- DownloadString：実行メモリバッファに内容をダウンロード

### [その他](https://www.haruru29.net/blog/how-to-download-files-using-powershell/)

- Invoke-WebRequest/wget
- curl (Windows 10 1803 以降)

### コマンド実行

- Invoke-Expression/iex：引数の文字列をコマンドとして実行
  ```powershell
  iex ((new-object net.webclient).DownloadString('URL'))
  ```
- Invoke-Command/icm：ローカルおよびリモートコンピュータでコマンドを実行
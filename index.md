---
layout: top
title: トップページ
---

## 技術

### 公開コード

- [GitHub Repositories](https://github.com/applejxd?tab=repositories)
- [GitHub Gist](https://gist.github.com/applejxd)

### 公開サイト
{% assign external_pages = site.data.external_pages %}{% if external_pages and external_pages.size > 0 %}
{% for page in external_pages %}- [{{ page.name }}]({{ page.url }}){% if page.description != "" %} - {{ page.description }}{% endif %}
{% endfor %}{% else %}
（公開中の GitHub Pages はありません）
{% endif %}

### 環境構築

- [dotfiles (GitHub)](https://github.com/applejxd/dotfiles)
- [Linux サーバメモ](pages/Linux/LinuxServer.md)
  - [Linux コマンドメモ](pages/Linux/LinuxCommand.md)
  - [シェルスクリプトメモ](pages/Linux/ShellScript.md)
  - [Vim メモ](pages/Linux/Vim.md)
  - [HPC メモ](pages/Linux/HPC.md)
  - [Ubuntu 設定メモ](pages/Linux/Ubuntu.md)
  - [ネットワークドライブマウントメモ](pages/Linux/Mount.md)
  - セキュリティ関連
    - [SSH メモ](pages/Linux/SSH.md)
    - [VPN 設定メモ](pages/Linux/VPN.md)
    - [UFW 設定メモ](pages/Linux/UFW.md)
- [Git メモ](pages/Git.md)
  - [GitHub メモ](pages/GitHub.md)
  - [GitHub 動作ステータス](https://www.githubstatus.com/)
- [Windows 設定 (GitHub)](https://github.com/applejxd/windows-setup)
  - [Windows メモ](pages/Windows/Windows.md)
  - [Powershell メモ](pages/Windows/PowerShell.md)
  - [Symlink メモ](pages/Windows/Symlink.md)
  - [WSL メモ](pages/Windows/WSL.md)
- [Mac メモ](pages/Mac.md)
- [Terminal 操作メモ](pages/Terminal.md)
- その他
  - [開発環境メモ](pages/Preferences.md)
  - [M5Stack メモ](pages/M5Stack.md)
  - [IDE メモ](pages/IDE.md)
  - [OSS メモ](pages/OSS.md)
  - [Keychron メモ](pages/Keychron.md)
  - [FPGA メモ](pages/FPGA.md)

### プログラミング

- [オブジェクト指向メモ](pages/ODD.md)
- [Python メモ](pages/Python/Python.md)
  - [Sphinx メモ](pages/Python/Sphinx.md)
- [C++ コーディングメモ](pages/Cpp/Cpp.md)
  - [競技プログラミング Tips](pages/Cpp/CppContest.md)
  - [CMake & C++ ビルドメモ](pages/Cpp/CppBuild.md)
  - [Doxygen メモ](pages/Cpp/Doxygen.md)
  - [C++ オブジェクト指向メモ](pages/Cpp/CppObject.md)
  - [C++ デバッグ/エラー処理](pages/Cpp/CppDebug.md)
  - [STL メモ](pages/Cpp/STL.md)
  - [OpenCV メモ](pages/Cpp/OpenCV.md)
  - [C++ ライブラリメモ](pages/Cpp/CppLibrary.md)
- [JVM メモ](pages/JVM.md)

## 学習メモ

- [CAD メモ](pages/CAD.md)
- [理学メモ](pages/Science.md)
- [資料作成メモ](pages/Document.md)
- [英語リンク集](pages/English.md)
- [リンク集](pages/Links.md)

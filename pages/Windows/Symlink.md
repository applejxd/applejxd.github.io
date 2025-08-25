---
title: Powershell で Symlink
---


## 1. シンボリックリンクの作成方法

### PowerShell 標準コマンド
PowerShell 5.0 以降:
```powershell
# ファイル
New-Item -ItemType SymbolicLink -Path "リンク名.txt" -Target "C:\path\to\実ファイル.txt"

# ディレクトリ
New-Item -ItemType SymbolicLink -Path "リンクフォルダ" -Target "C:\path\to\実フォルダ"
```

### mklink を利用
`cmd.exe` の内部コマンドを呼び出す方法:
```powershell
# ファイル
cmd /c mklink "リンク名.txt" "C:\path\to\実ファイル.txt"

# ディレクトリ
cmd /c mklink /D "リンクフォルダ" "C:\path\to\実フォルダ"
```

---

## 2. Junction との比較

| 種類 | コマンド例 (PowerShell) | 主な用途 | 特徴 |
|------|-------------------------|----------|------|
| **SymbolicLink** | `New-Item -ItemType SymbolicLink -Path "C:\Users\foo\.config" -Target "D:\dotfiles\config"` | 最新環境推奨 | - Vista以降<br>- NTFS必須<br>- ネットワークドライブも可<br>- 管理者権限 or 開発者モード必須<br>- Linuxのsymlinkと同等 |
| **Junction** | `New-Item -ItemType Junction -Path "C:\Users\foo\.config" -Target "D:\dotfiles\config"` | レガシー互換・安定 | - 2000以降<br>- NTFS必須<br>- ディレクトリ専用<br>- 管理者権限不要<br>- ネットワークドライブ不可 |

---

## 3. 選び方

- **Linux的な挙動やネットワーク越しも扱いたい** → **SymbolicLink**
- **管理者権限なしで安定利用したい（ローカル限定）** → **Junction**

---

## 4. dotfiles 用途の例

chezmoi 管理で `$HOME\.config` を差し替える場合:

### SymbolicLink
```powershell
New-Item -ItemType SymbolicLink -Path "$HOME\.config\fish" -Target "D:\dotfiles\.config\fish"
```

### Junction
```powershell
New-Item -ItemType Junction -Path "$HOME\.config\fish" -Target "D:\dotfiles\.config\fish"
```

---

## 5. 結論

- 普段は **Junction** を選ぶと安定（管理者不要・シンプル）。
- **Linux的な挙動やネットワーク経由を考慮する場合は SymbolicLink** を利用。
- chezmoi の方針がファイル単位管理であるため、Windows 環境ではシンボリックリンクかハードリンク利用の検討が自然。
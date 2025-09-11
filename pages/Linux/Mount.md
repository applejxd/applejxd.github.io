---
title: ネットワークドライブマウントメモ(Ubuntu)
---

## 基本
- 多くのNASやWindows共有は **SMB/CIFS** プロトコルを使用する  
- パッケージ導入：
  ```bash
  sudo apt-get install cifs-utils
  ```

## 一時的なマウント
```bash
sudo mount -t cifs //サーバIP/共有名 /mnt/share \
  -o username=ユーザー名,password=パスワード,uid=$(id -u),gid=$(id -g)
```
- `//サーバIP/共有名` : ネットワークドライブのパス
- `/mnt/share` : ローカルのマウント先
- `uid`, `gid` : 所有者を自分にするための指定

## 認証情報をファイルで管理
`/etc/cifs-credentials` を作成：
```ini
username=ユーザー名
password=パスワード
domain=WORKGROUP   # 必要な場合のみ
```

- 権限は `chmod 600 /etc/cifs-credentials`
- 記号は基本そのまま書ける  
  - 空白や `#` を含む場合は `"..."` で囲むか `\` でエスケープする

マウント例：
```bash
sudo mount -t cifs //192.168.1.10/share /mnt/share \
  -o credentials=/etc/cifs-credentials,uid=$(id -u),gid=$(id -g)
```

## /etc/fstab による自動マウント
```fstab
//192.168.1.10/share /mnt/share cifs \
  credentials=/etc/cifs-credentials,iocharset=utf8,uid=1000,gid=1000,file_mode=0664,dir_mode=0775 0 0
```

- `/etc/fstab` からのマウントは root 権限で行われるため、指定がなければ所有者は root になる  
- `uid` / `gid` を指定することでユーザーが使いやすい権限にできる  
- `file_mode`, `dir_mode` で読み書き権限を調整可能

## domain の意味
- Windows ドメイン環境（Active Directory など）で所属ドメインを指定する  
  - 例: `domain=COMPANY`  
- 家庭用NASやローカルPC共有の場合は不要（必要なら `WORKGROUP`）

---
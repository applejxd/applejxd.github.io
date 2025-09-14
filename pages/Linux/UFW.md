---
title: UFW メモ
---

## 1) UFW の初期設定（最小）

```bash
# 既定ポリシー（受信拒否・送信許可）
sudo ufw default deny incoming
sudo ufw default allow outgoing

# SSH を先に許可（ロックアウト防止）
sudo ufw allow OpenSSH    # 代替: sudo ufw allow 22/tcp

# 有効化
sudo ufw enable

# 状態確認（番号付き）
sudo ufw status numbered
```

---

## 2) Tailnet（tailscale0）向けにコメント付きで UFW ルールをセットする例

```bash
# すべて「tailscale0」インターフェース経由の通信だけ許可します
# ※ tailscale0 名は環境により異なる場合あり（ip addr で確認）

# SSH
sudo ufw allow in on tailscale0 to any port 22 proto tcp comment 'SSH for Tailscale network'

# xrdp（RDP）
sudo ufw allow in on tailscale0 to any port 3389 proto tcp comment 'RDP TCP for remote desktop'
sudo ufw allow in on tailscale0 to any port 3389 proto udp comment 'RDP UDP optimization'

# Web（HTTP/1.1/2）
sudo ufw allow in on tailscale0 to any port 80  proto tcp comment 'HTTP for web server via Tailscale'
sudo ufw allow in on tailscale0 to any port 443 proto tcp comment 'HTTPS/HTTP2 for secure web via Tailscale'

# HTTP/3（QUIC）は UDP を追加で開放する場合のみ
sudo ufw allow in on tailscale0 to any port 443 proto udp comment 'HTTP/3 QUIC for modern web'

# 反映確認
sudo ufw status numbered
```

---

## 3) UFW ルールの一括初期化・選択的削除

```bash
# A) 一括初期化（すべてのユーザールールを削除し初期状態へ）
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH
sudo ufw enable

# B) 選択的削除（番号指定）— 番号は「降順」で消すと安全
sudo ufw status numbered
sudo ufw delete 7          # 例：特定番号を削除
sudo ufw delete 5

# C) まとめて機械的に削除（降順ループ）
for n in $(sudo ufw status numbered | sed -n 's/^\[\([0-9]\+\)\].*/\1/p' | sort -rn); do
  sudo ufw --force delete "$n"
done

# D) ルール文法で直接削除（条件一致でピンポイント）
sudo ufw delete allow in on tailscale0 to any port 22 proto tcp
sudo ufw delete allow 443/udp
```

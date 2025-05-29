#!/bin/bash

set -e

# === Konfigurasi ===
C9_DIR="/home/c9sdk"
WORKSPACE_DIR="/home/cloud9ku"
C9_PORT=8080
C9_USER="root"
AUTH="username:password" #ganti username dan pass ini

if [ "$(id -u)" -ne 0 ]; then
  echo "Script ini harus dijalankan sebagai root!"
  exit 1
fi

echo "[+] Memperbarui sistem dan menginstal dependency..."
apt update -y
apt install -y build-essential git nodejs python2.7

if ! id "$C9_USER" &>/dev/null; then
  echo "[+] Membuat user $C9_USER..."
  adduser --disabled-password --gecos "" "$C9_USER"
fi

echo "[+] Clone Cloud9 SDK ke $C9_DIR..."
git clone https://github.com/c9/core.git "$C9_DIR"
cd "$C9_DIR"

echo "[+] Menjalankan install-sdk.sh..."
scripts/install-sdk.sh

echo "[+] Membuat systemd service untuk Cloud9..."

SERVICE_FILE="/etc/systemd/system/cloud9.service"
cat <<EOF > "$SERVICE_FILE"
[Unit]
Description=Cloud9 IDE
After=network.target

[Service]
Type=simple
User=$C9_USER
WorkingDirectory=$C9_DIR
ExecStart=/usr/bin/nodejs $C9_DIR/server.js -p $C9_PORT -l 0.0.0.0 -a $AUTH -w $WORKSPACE_DIR
Restart=always
Environment=HOME=$WORKSPACE_DIR

[Install]
WantedBy=multi-user.target
EOF

echo "[+] Reload systemd, enable dan start Cloud9..."
systemctl daemon-reload
systemctl enable cloud9
systemctl start cloud9

echo "[✓] Cloud9 IDE sekarang berjalan di port $C9_PORT"
echo "[i] Akses melalui: http://<IP-anda>:$C9_PORT"
echo "[i] Login dengan user:pass = $AUTH"
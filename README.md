# 📦 Cloud9 Installer - Otomatisasi Pasang & Jalankan Cloud9 IDE di Ubuntu

```bash
tested on ubuntu 22
```

Script ini akan:

- Install dependency
- Clone Cloud9 SDK (`c9sdk`)
- Setup systemd agar Cloud9 otomatis berjalan setelah restart

---

## 🚀 Cara Pakai

```bash
chmod +x install_cloud9.sh
sudo ./install_cloud9.sh
```

> **Note:** Script ini **harus dijalankan sebagai root** (`sudo`), karena akan membuat user, menginstall package, dan membuat service systemd.

---

## 📁 Struktur Direktori Default

- Cloud9 SDK akan di-install di: `/home/c9sdk`
- Workspace (folder kerja project): `/home/cloud9ku`

Jika ingin mengganti path default:

🔧 **Ubah manual di dalam script** bagian berikut:

```bash
C9_DIR="/home/c9sdk"
WORKSPACE_DIR="/home/cloud9ku"
```

---

## 🌐 Akses Cloud9

Setelah berhasil, akses Cloud9 IDE melalui browser:

```
http://<IP-ANDA>:8080
```

- Username: `username`
- Password: `password`

> 🛑 **Disarankan mengganti kredensial login (`-a username:password`) jika digunakan di jaringan publik.**

---

## 🛠️ Systemd Service

Cloud9 akan otomatis dijalankan via systemd:

```bash
sudo systemctl status cloud9
sudo systemctl restart cloud9
```

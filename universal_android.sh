#!/system/bin/sh
# StealthX Ultimate - Profil Peranti Android Sejagat (Selamat Merentas Jenama)

sh "$(dirname "$0")/stealthx_core.sh"

echo "[StealthX-Universal] Mengoptimumkan profil kompilasi masa jalan (ART)..."
cmd package compile -m speed-profile -f com.whatsapp >/dev/null 2>&1

echo "[SELESAI] Penalaan sejagat 0.0x selesai tanpa mengubah pakej sistem pengeluar."

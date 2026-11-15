#!/usr/bin/env bash
set -euo pipefail

# Senarai aplikasi disekat ke Standby Bucket 45 (Restricted)
RESTRICTED_PKGS=(
  "com.facebook.katana"
  "com.instagram.android"
  "com.mobile.legends"
  "com.ubisoft.redlynx.trialsfrontier.ggp"
  "com.mktv.steelkiwi.muslimkidstv"
  "com.blockchainvault"
  "pi.browser"
  "network.bee.app"
  "com.binance.dev"
  "com.google.android.apps.maps"
  "com.google.earth"
  "com.google.android.projection.gearhead"
  "com.google.android.apps.subscriptions.red"
  "com.google.android.apps.docs"
  "com.google.android.contacts"
  "com.google.android.documentsui"
  "com.android.providers.downloads.ui"
  "com.microsoft.office.word"
  "com.microsoft.office.powerpoint"
  "com.adobe.reader"
  "us.zoom.videomeetings"
  "com.lemon.lvoverseas"
  "com.openai.chatgpt"
  "org.zwanoo.android.speedtest"
  "com.miui.compass"
  "com.duokan.phone.remotecontroller"
  "com.mytnb.mytnb"
  "com.setel.mobile"
  "com.epf.mip"
  "my.gov.onegovappstore.myubat"
  "tuju.my"
  "com.shopee.my"
  "com.shopeepay.my"
  "com.lazada.android"
)

# Senarai pengecualian aplikasi kewangan (Standby Bucket 5 / Exempted)
WHITELIST_PKGS=(
  "com.cimb.cimbocto"
  "my.com.tngdigital.ewallet"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUDIT_DIR="${SCRIPT_DIR}/audits"
mkdir -p "$AUDIT_DIR"

MODEL=$(adb shell getprop ro.product.model | tr -d '\r' | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
AUDIT_FILE="${AUDIT_DIR}/${MODEL}-audit.txt"

echo "[1/5] Membersihkan blok storan kilat (sm fstrim)..."
adb shell sm fstrim

echo "[2/5] Mengunci penyegerakan awan & profil 60 FPS permainan..."
adb shell "device_config set_sync_disabled_for_tests persistent"
adb shell "device_config put game_overlay com.mobile.legends mode=3,downscaleFactor=1.0,fps=60 && cmd game mode battery com.mobile.legends"
adb shell "device_config put game_overlay com.supercell.clashofclans mode=3,downscaleFactor=0.85,fps=60 && cmd game mode battery com.supercell.clashofclans"

echo "[3/5] Menyekat proses latar belakang & wakelock (Standby Bucket 45)..."
for pkg in "${RESTRICTED_PKGS[@]}"; do
  if adb shell pm path "$pkg" >/dev/null 2>&1; then
    adb shell "cmd appops set $pkg RUN_IN_BACKGROUND ignore && \
               cmd appops set $pkg RUN_ANY_IN_BACKGROUND ignore && \
               cmd appops set $pkg WAKE_LOCK ignore && \
               am set-standby-bucket $pkg restricted"
    echo "  -> Dikunci (Bucket 45): $pkg"
  fi
done

echo "[4/5] Mengecualikan aplikasi kewangan (Standby Bucket 5 / Exempted)..."
for pkg in "${WHITELIST_PKGS[@]}"; do
  if adb shell pm path "$pkg" >/dev/null 2>&1; then
    adb shell "dumpsys deviceidle whitelist +$pkg && \
               cmd appops set $pkg RUN_ANY_IN_BACKGROUND allow && \
               am set-standby-bucket $pkg active"
    echo "  -> Senarai Putih Aktif: $pkg"
  fi
done

echo "[5/5] Menjana laporan pengauditan sistem ke $AUDIT_FILE..."
{
  echo "=== LAPORAN PENGAUDITAN STEALTHX ($(date -Iseconds)) ==="
  echo "Model Peranti: $(adb shell getprop ro.product.model | tr -d '\r')"
  echo "Versi Android: $(adb shell getprop ro.build.version.release | tr -d '\r')"
  echo ""
  echo "--- Pemacu Grafik & Kadar Segar Semula ---"
  adb shell "settings get global updatable_driver_all_apps && dumpsys SurfaceFlinger | grep -iE 'refresh-rate|fps' | head -n 4"
  echo ""
  echo "--- Senarai Putih Kewangan (deviceidle whitelist) ---"
  adb shell "dumpsys deviceidle whitelist | grep -E 'cimbocto|tngdigital'"
  echo ""
  echo "--- Senarai Aplikasi Terhad (Standby Bucket 45) ---"
  adb shell "am get-standby-bucket | grep ': 45'"
} > "$AUDIT_FILE"

echo "Selesai. Laporan pengauditan disimpan di $AUDIT_FILE"

#!/usr/bin/env bash
# Profil Penalaan StealthX_Ultimate — Samsung Galaxy J4 (eMMC 5.1)
set -euo pipefail

ADB_CMD="adb"
if sudo adb get-state >/dev/null 2>&1; then
  ADB_CMD="sudo adb"
fi

echo "[>>>] Memulakan Penyelenggaraan StealthX — Samsung Galaxy J4..."
$ADB_CMD shell '
  echo "[1/4] Membersihkan blok storan kilat eMMC (sm fstrim)..."
  sm fstrim

  echo "[2/4] Mematikan Daydream & perkhidmatan latar belakang Samsung..."
  settings put secure screensaver_enabled 0
  settings put secure screensaver_activate_on_dock 0
  settings put secure screensaver_activate_on_sleep 0
  for SBLOAT in com.android.dreams.basic com.android.dreams.phototable com.samsung.android.beaconmanager com.samsung.android.easysetup com.samsung.android.game.gos com.samsung.android.game.gametools; do
    pm uninstall -k --user 0 "$SBLOAT" >/dev/null 2>&1 && echo "  -> Dinyahaktifkan: $SBLOAT"
  done

  echo "[3/4] Menala parameter Doze & mengecualikan AccuBattery serta 1.1.1.1..."
  settings put global device_idle_constants inactive_to=30000,sensing_to=0,locating_to=0,motion_inactive_to=0,idle_after_inactive_to=0
  settings put global ble_scan_always_enabled 0
  settings put global wifi_scan_always_enabled 0
  dumpsys deviceidle whitelist +com.digibites.accubattery >/dev/null 2>&1
  dumpsys deviceidle whitelist +com.cloudflare.onedotonedotonedotone >/dev/null 2>&1

  echo "[4/4] Menyekat WAKE_LOCK aplikasi berat (Dr. Safety & 1.1.1.1 dikekalkan)..."
  for PKG in com.squareenixmontreal.lcgo com.microsoft.emmx.canary com.tm.unifitv.mobile jp.co.shueisha.mangaplus com.google.android.apps.photos; do
    if pm path "$PKG" >/dev/null 2>&1; then
      cmd appops set "$PKG" RUN_IN_BACKGROUND ignore >/dev/null 2>&1
      cmd appops set "$PKG" RUN_ANY_IN_BACKGROUND ignore >/dev/null 2>&1
      cmd appops set "$PKG" WAKE_LOCK ignore >/dev/null 2>&1
      am set-standby-bucket "$PKG" restricted >/dev/null 2>&1
      echo "  -> Disekat latar belakang: $PKG"
    fi
  done
'
echo "[<<<] Penyelenggaraan Samsung Galaxy J4 selesai."

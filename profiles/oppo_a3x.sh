#!/usr/bin/env bash
# Profil Penalaan StealthX_Ultimate — OPPO A3x (CPH2641 | Platform: bengal 11nm)
# Dioptimumkan untuk perlindungan haba & kawalan latar belakang Facebook/TikTok bonda
set -euo pipefail

ADB_CMD="adb"
if ! adb get-state >/dev/null 2>&1 && sudo adb get-state >/dev/null 2>&1; then
  ADB_CMD="sudo adb"
fi

echo "[>>>] Memulakan Penalaan Perlindungan StealthX — OPPO A3x (CPH2641 / ColorOS 14)..."
$ADB_CMD shell '
  echo "[1/6] Membersihkan blok storan kilat eMMC 5.1 (sm fstrim)..."
  sm fstrim

  echo "[2/6] Mengunci paparan kepada 60 Hz & mempercepatkan skala animasi (0.5x)..."
  settings put system peak_refresh_rate 60.0
  settings put system min_refresh_rate 60.0
  settings put global animator_duration_scale 0.5
  settings put global transition_animation_scale 0.5
  settings put global window_animation_scale 0.5

  echo "[3/6] Membuang telemetri, iklan & bloatware ColorOS / HeyTap / Amazon / Meta..."
  for OBLOAT in \
    com.heytap.market \
    com.heytap.themestore \
    com.heytap.browser \
    com.heytap.cloud \
    com.heytap.mcs \
    com.heytap.pictorial \
    com.heytap.usercenter \
    com.heytap.mall \
    com.oplus.member \
    com.amazon.appmanager \
    com.glance.internet \
    com.coloros.gamespace \
    com.oplus.games \
    com.oplus.crashbox \
    com.oplus.logkit \
    com.redteamobile.roaming \
    com.facebook.system \
    com.facebook.appmanager \
    com.facebook.services; do
    pm uninstall -k --user 0 "$OBLOAT" >/dev/null 2>&1 && echo "  -> Dibuang: $OBLOAT"
  done

  echo "[4/6] Menyekat WAKE_LOCK & aktiviti latar belakang Facebook, TikTok serta aplikasi berat..."
  for HPKG in \
    com.facebook.katana \
    com.facebook.lite \
    com.facebook.orca \
    com.ss.android.ugc.trill \
    com.zhiliaoapp.musically \
    com.instagram.android \
    com.shopee.my \
    com.lazada.android \
    com.trendmicro.freetmms.lite; do
    if pm path "$HPKG" >/dev/null 2>&1; then
      cmd appops set "$HPKG" RUN_IN_BACKGROUND ignore >/dev/null 2>&1
      cmd appops set "$HPKG" RUN_ANY_IN_BACKGROUND ignore >/dev/null 2>&1
      cmd appops set "$HPKG" WAKE_LOCK ignore >/dev/null 2>&1
      am set-standby-bucket "$HPKG" rare >/dev/null 2>&1
      echo "  -> Dikawal (Latar Belakang Disekat): $HPKG"
    fi
  done

  echo "[5/6] Menala parameter Deep Doze & mematikan imbasan pasif latar belakang..."
  settings put global device_idle_constants inactive_to=30000,sensing_to=0,locating_to=0,motion_inactive_to=0,idle_after_inactive_to=0
  settings put global ble_scan_always_enabled 0
  settings put global wifi_scan_always_enabled 0

  echo "[6/6] Mengecualikan aplikasi penting bonda (WhatsApp, MyUnifi, AccuBattery)..."
  for WPKG in com.whatsapp my.myunifi com.digibites.accubattery; do
    if pm path "$WPKG" >/dev/null 2>&1; then
      dumpsys deviceidle whitelist +"$WPKG" >/dev/null 2>&1
      echo "  -> Dikecualikan Doze: $WPKG"
    fi
  done
  true
'
echo "[<<<] Penalaan OPPO A3x (CPH2641) selesai."

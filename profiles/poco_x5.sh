#!/usr/bin/env bash
# Profil Penalaan StealthX_Ultimate — POCO X5 5G (22111317PG | moonstone / SM6375)
# Dioptimumkan untuk sifar animasi (0.0x), kunci 60Hz HyperOS & kompilasi WebView
set -euo pipefail

ADB_CMD="adb"
if ! adb get-state >/dev/null 2>&1 && sudo adb get-state >/dev/null 2>&1; then
  ADB_CMD="sudo adb"
fi

echo "[>>>] Memulakan Penalaan StealthX — POCO X5 5G (HyperOS)..."
$ADB_CMD shell '
  echo "[1/4] Membersihkan blok storan kilat UFS 2.2 (sm fstrim)..."
  sm fstrim

  echo "[2/4] Mematikan sepenuhnya skala animasi (0.0x) & mengunci paparan 60 Hz..."
  settings put global window_animation_scale 0.0
  settings put global transition_animation_scale 0.0
  settings put global animator_duration_scale 0.0
  settings put system user_refresh_rate 60
  settings put system peak_refresh_rate 60.0
  settings put system min_refresh_rate 60.0

  echo "[3/4] Mengkompilasi binaan Android System WebView ke kod natif (speed-profile)..."
  cmd package compile -m speed-profile -f com.google.android.webview

  echo "[4/4] Pengesahan parameter sistem..."
  echo "  window_animation_scale     : $(settings get global window_animation_scale)"
  echo "  transition_animation_scale : $(settings get global transition_animation_scale)"
  echo "  animator_duration_scale   : $(settings get global animator_duration_scale)"
  echo "  user_refresh_rate (Hz)     : $(settings get system user_refresh_rate)"
  echo "  WebView aktif              : $(dumpsys webviewupdate | grep "Current WebView package" | xargs)"
'
echo "[<<<] Penalaan POCO X5 5G selesai sepenuhnya."

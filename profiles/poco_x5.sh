#!/usr/bin/env bash
# Profil Penalaan StealthX_Ultimate — POCO X5 5G (22111317PG | moonstone / SM6375)
# Dioptimumkan untuk sifar animasi (0.0x), kunci 60Hz HyperOS, kompilasi WebView
# serta penutupan automatik Pilihan Pembangun & pintasan terus ke menu Buang Animasi.
set -euo pipefail

ADB_CMD="adb"
if ! adb get-state >/dev/null 2>&1 && sudo adb get-state >/dev/null 2>&1; then
  ADB_CMD="sudo adb"
fi

echo "[>>>] Memulakan Penalaan StealthX — POCO X5 5G (HyperOS)..."
$ADB_CMD shell '
  echo "[1/5] Membersihkan blok storan kilat UFS 2.2 (sm fstrim)..."
  sm fstrim >/dev/null

  echo "[2/5] Menetapkan skala animasi (0.0x) & paparan 60 Hz..."
  for KEY in window_animation_scale transition_animation_scale animator_duration_scale; do
    settings put global "$KEY" 0.0 2>/dev/null || true
  done
  settings put system remove_animations 1 2>/dev/null || true
  settings put system reduce_animations 1 2>/dev/null || true
  settings put system user_refresh_rate 60 2>/dev/null || true
  settings put system peak_refresh_rate 60.0 2>/dev/null || true
  settings put system min_refresh_rate 60.0 2>/dev/null || true

  echo "[3/5] Mengkompilasi binaan Android System WebView ke kod natif (speed-profile)..."
  cmd package compile -m speed-profile -f com.google.android.webview

  echo "[4/5] Membuka terus menu Kebolehcapaian (Accessibility) pada skrin peranti..."
  am start -a android.settings.ACCESSIBILITY_SETTINGS >/dev/null 2>&1 || true

  echo "[5/5] Mematikan Pilihan Pembangun (Developer Options) untuk keserasian perbankan..."
  if settings put global development_settings_enabled 0 2>/dev/null; then
    echo "  [OK] Pilihan Pembangun berjaya dimatikan secara automatik."
  else
    echo "  [!] HyperOS menyekat penutupan automatik: matikan suis Pilihan Pembangun secara manual."
  fi
' || true

echo "[<<<] Selesai. Sila aktifkan suis 'Buang animasi' (Remove animations) pada skrin Kebolehcapaian yang terpapar."

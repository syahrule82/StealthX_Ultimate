#!/usr/bin/env bash
# Profil Penalaan StealthX_Ultimate — POCO X5 5G (HyperOS)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ADB_CMD="adb"
if ! adb get-state >/dev/null 2>&1 && sudo adb get-state >/dev/null 2>&1; then
  ADB_CMD="sudo adb"
fi

echo "[>>>] Memulakan Penalaan StealthX — POCO X5 5G (HyperOS)..."
$ADB_CMD shell '
  sm fstrim >/dev/null 2>&1 || true
  for KEY in window_animation_scale transition_animation_scale animator_duration_scale; do
    settings put global "$KEY" 0.0 2>/dev/null || true
  done
  settings put system remove_animations 1 2>/dev/null || true
  settings put system reduce_animations 1 2>/dev/null || true
  settings put system user_refresh_rate 60 2>/dev/null || true
  settings put system peak_refresh_rate 60.0 2>/dev/null || true
  settings put system min_refresh_rate 60.0 2>/dev/null || true

  for SYS_PKG in com.miui.powerkeeper com.miui.screenrecorder; do
    cmd package install-existing "$SYS_PKG" >/dev/null 2>&1 || true
    pm enable "$SYS_PKG" >/dev/null 2>&1 || true
  done
  cmd appops set com.miui.screenrecorder PROJECT_MEDIA allow >/dev/null 2>&1 || true

  cmd package compile -m speed-profile -f com.google.android.webview >/dev/null 2>&1 || true
  am start -a android.settings.ACCESSIBILITY_SETTINGS >/dev/null 2>&1 || true
' || true

bash "${SCRIPT_DIR}/../core/nuke_animations.sh" || true
bash "${SCRIPT_DIR}/../stealthx_tune.sh" || true

$ADB_CMD shell 'settings put global development_settings_enabled 0 2>/dev/null || true' || true
echo "[<<<] Selesai. Pastikan suis Buang animasi (Remove animations) aktif & matikan Pilihan Pembangun secara manual."

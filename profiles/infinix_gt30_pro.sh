#!/usr/bin/env bash
# Profil Penalaan StealthX_Ultimate — Infinix GT 30 Pro (XOS)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ADB_CMD="adb"
if ! adb get-state >/dev/null 2>&1 && sudo adb get-state >/dev/null 2>&1; then
  ADB_CMD="sudo adb"
fi

echo "[>>>] Memulakan Penalaan StealthX — Infinix GT 30 Pro (XOS)..."
$ADB_CMD shell '
  sm fstrim >/dev/null 2>&1 || true
  for XOS_PKG in com.transsion.powercenter com.transsion.batterylab com.transsion.screenrecorder com.transsion.gamemode; do
    cmd package install-existing "$XOS_PKG" >/dev/null 2>&1 || true
    pm enable "$XOS_PKG" >/dev/null 2>&1 || true
  done
  cmd appops set com.transsion.screenrecorder PROJECT_MEDIA allow >/dev/null 2>&1 || true
  for BLOAT in com.transsion.plat.appupdate com.transsion.trancare; do
    cmd appops set "$BLOAT" RUN_IN_BACKGROUND ignore >/dev/null 2>&1 || true
    cmd appops set "$BLOAT" RUN_ANY_IN_BACKGROUND ignore >/dev/null 2>&1 || true
  done
  cmd package compile -m speed-profile -f com.google.android.webview >/dev/null 2>&1 || true
  am start -a android.settings.ACCESSIBILITY_SETTINGS >/dev/null 2>&1 || true
' || true

bash "${SCRIPT_DIR}/../core/nuke_animations.sh" || true
bash "${SCRIPT_DIR}/../stealthx_tune.sh" || true
$ADB_CMD shell 'settings put global development_settings_enabled 0 2>/dev/null || true' || true
echo "[<<<] Penalaan Infinix GT 30 Pro selesai."

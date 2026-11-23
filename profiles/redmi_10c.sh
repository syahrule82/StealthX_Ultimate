#!/usr/bin/env bash
# Profil Penalaan StealthX_Ultimate — Redmi 10C (fog | Snapdragon 680)
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[>>>] Memulakan Penalaan StealthX — Redmi 10C..."
bash "$SCRIPT_DIR/../core/nuke_animations.sh"
adb shell '
  sm fstrim >/dev/null 2>&1 || true
  settings put system user_refresh_rate 60 2>/dev/null || true
  cmd package compile -m speed-profile -f com.google.android.webview 2>/dev/null || true
  am start -a android.settings.ACCESSIBILITY_SETTINGS >/dev/null 2>&1 || true
  settings put global development_settings_enabled 0 2>/dev/null || true
' || true
echo "[<<<] Penalaan Redmi 10C (0.0x) selesai."

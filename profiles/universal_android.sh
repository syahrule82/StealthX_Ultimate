#!/usr/bin/env bash
# Profil Penalaan StealthX_Ultimate — Peranti Android Sejagat
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "[>>>] Memulakan Penalaan StealthX — Profil Android Sejagat..."
adb shell 'sm fstrim >/dev/null 2>&1 || true; cmd package compile -m speed-profile -f com.google.android.webview >/dev/null 2>&1 || true' || true
bash "${SCRIPT_DIR}/../core/nuke_animations.sh" || true
bash "${SCRIPT_DIR}/../stealthx_tune.sh" || true
adb shell 'settings put global development_settings_enabled 0 2>/dev/null || true' || true
echo "[<<<] Penalaan sejagat selesai."

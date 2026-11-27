#!/usr/bin/env bash
# Modul Teras StealthX_Ultimate — Pemusnah Animasi Mutlak (0.0x) Semua OEM
set -euo pipefail

ADB_CMD="adb"
if ! adb get-state >/dev/null 2>&1 && sudo adb get-state >/dev/null 2>&1; then
  ADB_CMD="sudo adb"
fi

echo "[STEALTHX-ZERO-ANIM] Menghancurkan semua lapisan animasi sistem & OEM (0.0x)..."
$ADB_CMD shell << 'ADB_EOF'
for KEY in window_animation_scale transition_animation_scale animator_duration_scale; do
  settings put global "$KEY" 0.0 2>/dev/null || true
done

settings put global fancy_ime_animations 0 2>/dev/null || true
settings put global disable_window_blurs 1 2>/dev/null || true
settings put system disable_window_blurs 1 2>/dev/null || true
settings put system remove_animations 1 2>/dev/null || true
settings put system reduce_animations 1 2>/dev/null || true
settings put system miui_home_animation_rate 0 2>/dev/null || true
settings put system oppo_animation_scale 0.0 2>/dev/null || true
settings put secure oppo_animation_scale 0.0 2>/dev/null || true
settings put system transsion_animation_scale 0.0 2>/dev/null || true

echo "  window_animation_scale     : $(settings get global window_animation_scale)"
echo "  transition_animation_scale : $(settings get global transition_animation_scale)"
echo "  animator_duration_scale   : $(settings get global animator_duration_scale)"
echo "  remove_animations          : $(settings get system remove_animations)"
ADB_EOF

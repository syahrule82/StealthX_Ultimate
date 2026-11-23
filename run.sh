#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[>>>] Memulakan Protokol STEALTHX UNIVERSAL..."
adb wait-for-device

echo "[+] Fasa 1: Memancung telemetri OEM..."
adb shell '
  for PKG in \
    com.google.android.feedback com.google.android.printservice.recommendation \
    com.android.traceur com.android.printspooler com.android.bookmarkprovider \
    com.miui.analytics com.miui.msa.global com.miui.bugreport com.miui.daemon com.xiaomi.joyose \
    com.samsung.android.bixby.agent com.samsung.android.app.spage \
    com.samsung.android.sm.devicesecurity com.sec.android.diagmonagent \
    com.coloros.phonemanager com.heytap.usercenter com.vivo.hybrid com.oplus.statistics.rom; do
    pm uninstall -k --user 0 "$PKG" >/dev/null 2>&1 || true
  done
'

echo "[+] Fasa 2 & 3: Menala WebView, animasi & imbasan pasif..."
adb shell '
  settings put global webview_multiprocess 1 2>/dev/null || true
  settings put global safe_browsing_enabled 0 2>/dev/null || true
  settings put global window_animation_scale 0.0 2>/dev/null || true
  settings put global transition_animation_scale 0.0 2>/dev/null || true
  settings put global animator_duration_scale 0.0 2>/dev/null || true
  settings put global mobile_data_always_on 0 2>/dev/null || true
  settings put global ble_scan_always_enabled 0 2>/dev/null || true
'

echo "[+] Fasa 4: Membersihkan cache Dalvik/ART..."
adb shell 'pm trim-caches 999999999999999999' >/dev/null 2>&1 || true

echo "[+] Fasa 5: Menjalankan stealthx_tune.sh & audit..."
bash "${SCRIPT_DIR}/stealthx_tune.sh"

echo "[<<<] Selesai. Menutup akses pembangun & but semula..."
adb shell 'settings put global development_settings_enabled 0 2>/dev/null || true'
sleep 2
adb reboot || true

bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/core/nuke_animations.sh" || true

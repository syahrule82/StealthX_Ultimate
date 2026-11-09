#!/bin/bash
echo "[>>>] Memulakan Protokol STEALTHX UNIVERSAL (Telefon, TV, IoT, Jam Pintar)..."

# FASA 1: Pangkalan Data Telemetri Universal (Merentas Jenama)
UNIVERSAL_BLOAT=(
  # Telemetri Asas Google & AOSP (Beban Latar Belakang)
  "com.google.android.feedback"
  "com.google.android.printservice.recommendation"
  "com.android.traceur"
  "com.android.printspooler"
  "com.android.bookmarkprovider"
  
  # Xiaomi / HyperOS / Poco
  "com.miui.analytics"
  "com.miui.msa.global"
  "com.miui.bugreport"
  "com.miui.daemon"
  "com.xiaomi.joyose"
  
  # Samsung OneUI
  "com.samsung.android.bixby.agent"
  "com.samsung.android.app.spage"
  "com.samsung.android.sm.devicesecurity"
  "com.sec.android.diagmonagent"
  
  # BBK Electronics (Oppo / Vivo / Realme / OnePlus)
  "com.coloros.phonemanager"
  "com.heytap.usercenter"
  "com.vivo.hybrid"
  "com.oplus.statistics.rom"
)

echo "[+] Memancung akar telemetri peranti..."
for PKG in "${UNIVERSAL_BLOAT[@]}"; do
  # Arahan ini akan mengabaikan pakej yang tidak wujud pada peranti tanpa mengeluarkan ralat
  pm uninstall -k --user 0 $PKG >/dev/null 2>&1
done

# FASA 2: Optimasi Teras Android System WebView
echo "[+] Mengaktifkan WebView Multiprocess & Rendering Berprestasi Tinggi..."
# Memaksa WebView beroperasi secara proses berbilang (sangat stabil untuk TV/Radio Kereta)
settings put global webview_multiprocess 1
# Melumpuhkan telemetri pelayar selamat (Safe Browsing) yang menyedut memori di latar belakang
settings put global safe_browsing_enabled 0

# FASA 3: Penalaan Kependaman UI & Kuasa Ekstrem
echo "[+] Menala kelancaran antara muka dan mematikan pengimbasan pasif..."
settings put global window_animation_scale 0.0
settings put global transition_animation_scale 0.0
settings put global animator_duration_scale 0.0
# Mematikan pencarian isyarat 4G/5G berterusan apabila menggunakan Wi-Fi
settings put global mobile_data_always_on 0
# Mematikan imbasan Bluetooth (BLE) berterusan di latar belakang (Penting untuk IoT)
settings put global ble_scan_always_enabled 0
settings put global development_settings_enabled 0

# FASA 4: Pembersihan Ruang Pemasangan
echo "[+] Membersihkan cache memori Dalvik/ART..."
pm trim-caches 999999999999999999

echo "[<<<] StealthX Universal Selesai. Ekosistem peranti kini berada di tahap optimum."
sleep 3
reboot

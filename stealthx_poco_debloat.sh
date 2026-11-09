#!/bin/bash

# Nama Fail: stealthx_poco_debloat.sh
# Projek: StealthX_Ultimate - Poco X5 5G Absolute
# Pembangun: Mohd Syahrulzaman bin Saharani (syahrule82)

echo "Memulakan protokol StealthX Poco Absolute..."

# 1. Pembuangan Pelayar & Media Xiaomi
pm uninstall -k --user 0 com.mi.globalbrowser
pm uninstall -k --user 0 com.android.browser
pm uninstall -k --user 0 com.miui.player
pm uninstall -k --user 0 com.miui.videoplayer
pm uninstall -k --user 0 com.miui.gallery

# 2. Pembuangan Telemetri, Pengintipan & Iklan (MSA)
pm uninstall -k --user 0 com.miui.msa.global
pm uninstall -k --user 0 com.miui.analytics
pm uninstall -k --user 0 com.miui.daemon
pm uninstall -k --user 0 com.xiaomi.mipicks

# 3. MODIFIKASI PSEUDO-UNDERCLOCK (PENJIMATAN BATERI TEGAR)
echo "Mematikan penggalak prestasi paksa (Pseudo-Underclock)..."
pm uninstall -k --user 0 com.xiaomi.joyose
pm uninstall -k --user 0 com.miui.powerkeeper

echo "Menyuntik profil penjimatan maksimum..."
settings put global low_power 1
settings put global restricted_device_performance 1,1
settings put secure thermal_limit_refresh_rate 0
settings put global activity_manager_constants max_cached_processes=3

# 4. PENGOPTIMUMAN GPU VULKAN GLOBAL & RESPONS SENTUHAN
echo "Meningkatkan prestasi Vulkan Global HWUI..."
setprop debug.hwui.renderer skiavk
setprop debug.hwui.use_vulkan true
settings put global hardware_accelerated 1
settings put global windows_mgr_max_events_per_sec 120

echo "Pembersihan dan Pengoptimuman GPU Poco X5 5G selesai!"

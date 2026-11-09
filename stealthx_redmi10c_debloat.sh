#!/bin/bash
# ===================================================
# StealthX Ultimate: Redmi 10C Optimization Script
# Target: Snapdragon 680 / Adreno 610 (Non-Root)
# ===================================================

echo "Memulakan Protokol StealthX pada Redmi 10C..."

# 1. Nyah-lewah Aplikasi Lewah & Telemetri Xiaomi/Redmi
pm uninstall -k --user 0 com.mi.globalbrowser
pm uninstall -k --user 0 com.android.browser
pm uninstall -k --user 0 com.miui.player
pm uninstall -k --user 0 com.miui.videoplayer
pm uninstall -k --user 0 com.miui.gallery
pm uninstall -k --user 0 com.miui.msa.global
pm uninstall -k --user 0 com.miui.analytics
pm uninstall -k --user 0 com.miui.daemon
pm uninstall -k --user 0 com.xiaomi.mipicks

# 2. Pseudo-Underclock: Mematikan Joyose & Powerkeeper (Penjimat Bateri)
pm uninstall -k --user 0 com.xiaomi.joyose
pm uninstall -k --user 0 com.miui.powerkeeper

# 3. Pecutan GPU SkiaVK Vulkan Global (Sesuai untuk Adreno 610)
setprop debug.hwui.renderer skiavk
setprop debug.hwui.use_vulkan true

echo "Suntikan StealthX Redmi 10C Berjaya 100%!"

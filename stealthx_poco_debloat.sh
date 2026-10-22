#!/bin/bash

Nama Fail: stealthx_poco_debloat.sh
Projek: StealthX_Ultimate - Poco X5 5G Absolute
Pembangun: Mohd Syahrulzaman bin Saharani (syahrule82)
Tujuan: Penghapusan telemetri Xiaomi, MSA, Iklan dan perisian lewah
echo "Memulakan protokol StealthX Poco Absolute..."

1. Pembuangan Pelayar & Media Xiaomi
pm uninstall -k --user 0 com.mi.globalbrowser
pm uninstall -k --user 0 com.android.browser
pm uninstall -k --user 0 com.miui.player
pm uninstall -k --user 0 com.miui.videoplayer
pm uninstall -k --user 0 com.miui.gallery

2. Pembuangan Telemetri, Pengintipan & Iklan (MSA)
pm uninstall -k --user 0 com.miui.msa.global
pm uninstall -k --user 0 com.miui.analytics
pm uninstall -k --user 0 com.miui.daemon
pm uninstall -k --user 0 com.xiaomi.mipicks
pm uninstall -k --user 0 com.xiaomi.joyose

echo "Pembersihan Poco X5 5G selesai. Sila reboot peranti."

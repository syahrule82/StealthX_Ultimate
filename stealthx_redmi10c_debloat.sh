#!/bin/bash
# Nama Fail: stealthx_redmi10c_debloat.sh
# Projek: StealthX_Ultimate - Redmi 10C (fog) Absolute
# Pembangun: Mohd Syahrulzaman bin Saharani (syahrule82)
# Tujuan: Penghapusan Mi Gallery dan pengoptimuman Redmi 10C

echo "Memulakan protokol StealthX Redmi 10C Absolute..."

# 1. Pembuangan Mi Gallery
pm uninstall -k --user 0 com.miui.gallery

echo "Pembersihan Redmi 10C selesai. Sila reboot peranti."

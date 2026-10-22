#!/bin/bash
# Nama Fail: stealthx_j4_debloat.sh
# Projek: StealthX_Ultimate - J4 Absolute
# Pembangun: Mohd Syahrulzaman bin Saharani (syahrule82)
# Tujuan: Penghapusan telemetri OEM, Meta, dan pengoptimuman UI untuk Samsung J4

echo "Memulakan protokol StealthX J4 Absolute..."

# 1. Pembuangan Aplikasi Sistem Samsung yang Menggunakan RAM
pm uninstall -k --user 0 com.sec.android.gallery3d
pm uninstall -k --user 0 com.sec.android.inputmethod
pm uninstall -k --user 0 com.samsung.android.lool
pm uninstall -k --user 0 com.sec.android.app.samsungapps
pm uninstall -k --user 0 com.mygalaxy

# 2. Pembuangan Ekosistem Telemetri Meta / Facebook
pm uninstall -k --user 0 com.facebook.katana
pm uninstall -k --user 0 com.facebook.system
pm uninstall -k --user 0 com.facebook.appmanager

# 3. Pembuangan Aplikasi Rangkaian Komersial
pm uninstall -k --user 0 com.linkedin.android

# 4. Pemadaman Skala Animasi Sistem (Sifar Lengah)
settings put global window_animation_scale 0.0
settings put global transition_animation_scale 0.0
settings put global animator_duration_scale 0.0

echo "Pembersihan telemetri selesai. Sila reboot peranti."

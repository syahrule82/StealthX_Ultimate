#!/bin/bash
# ==============================================================================
# StealthX_Ultimate - Non-Root Aggressive Optimization Script
# Author: Mohd Syahrulzaman bin Saharani
# Repository: https://github.com/syahrule82/StealthX_Ultimate
# ==============================================================================

echo "[+] Memulakan pengoptimuman StealthX_Ultimate..."
echo "[+] Menunggu peranti ADB bersambung..."
adb wait-for-device

echo "----------------------------------------------------"
echo "[1] Mengaktifkan Mod Doze Agresif (Penjimatan Bateri)"
echo "----------------------------------------------------"
adb shell dumpsys deviceidle enable
adb shell dumpsys deviceidle force-idle
adb shell settings put global device_idle_constants light_after_inactive_to=15000,light_idle_to=300000,light_idle_maintenance_max_budget=30000

echo "----------------------------------------------------"
echo "[2] Mematikan Skala Animasi (Prestasi Pantas)"
echo "----------------------------------------------------"
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0

echo "----------------------------------------------------"
echo "[3] Melaksanakan Pembersihan Storan (FSTRIM)"
echo "----------------------------------------------------"
adb shell sm fstrim -u 0

echo "===================================================="
echo "[✓] PENGOPTIMUMAN BERJAYA SELESAI!"
echo "[!] Sila matikan suis 'Wireless debugging' di telefon untuk keselamatan perbankan."
echo "===================================================="O

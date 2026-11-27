#!/system/bin/sh
# StealthX Ultimate - Profil Infinix GT 30 Pro (XOS)

sh "$(dirname "$0")/stealthx_core.sh"

echo "[StealthX-Infinix] Mengekalkan integriti Power Marathon, XArena & Perakam OEM..."
for xos_pkg in com.transsion.powercenter com.transsion.batterylab com.transsion.screenrecorder com.transsion.gamemode; do
    cmd package install-existing "$xos_pkg" >/dev/null 2>&1
    pm enable "$xos_pkg" >/dev/null 2>&1
done
cmd appops set com.transsion.screenrecorder PROJECT_MEDIA allow >/dev/null 2>&1

echo "[StealthX-Infinix] Mengehadkan perkhidmatan analitik latar belakang XOS..."
for bloat in com.transsion.plat.appupdate com.transsion.trancare; do
    cmd appops set "$bloat" RUN_IN_BACKGROUND ignore >/dev/null 2>&1
    cmd appops set "$bloat" RUN_ANY_IN_BACKGROUND ignore >/dev/null 2>&1
done

echo "[SELESAI] Infinix GT 30 Pro ditala. Sila matikan Developer Options secara manual demi keselamatan perbankan."

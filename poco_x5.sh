#!/system/bin/sh
# StealthX Ultimate - Profil POCO X5 5G (HyperOS)

sh "$(dirname "$0")/stealthx_core.sh"

echo "[StealthX-POCO] Memulihkan & mengunci modul kuasa dan perakam OEM..."
for sys_pkg in com.miui.powerkeeper com.miui.screenrecorder; do
    cmd package install-existing "$sys_pkg" >/dev/null 2>&1
    pm enable "$sys_pkg" >/dev/null 2>&1
done
cmd appops set com.miui.screenrecorder PROJECT_MEDIA allow >/dev/null 2>&1

echo "[StealthX-POCO] Melumpuhkan telemetri iklan sistem..."
for bloat in com.miui.msa.global com.miui.daemon; do
    pm disable-user --user 0 "$bloat" >/dev/null 2>&1
done

echo "[SELESAI] POCO X5 5G ditala. Sila matikan Developer Options secara manual demi keselamatan perbankan."

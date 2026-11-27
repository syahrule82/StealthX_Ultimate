#!/system/bin/sh
# StealthX Ultimate - Modul Teras Sejagat (0.0x & Kawalan Latar Belakang)

echo "[StealthX] Menetapkan enjin animasi sifar (0.0x)..."
settings put global window_animation_scale 0
settings put global transition_animation_scale 0
settings put global animator_duration_scale 0

echo "[StealthX] Mengunci sekatan latar belakang aplikasi berarus tinggi..."
for pkg in com.shopee.my com.lazada.android pi.browser; do
    if pm list packages | grep -q "^package:${pkg}$"; then
        cmd appops set "$pkg" RUN_IN_BACKGROUND ignore >/dev/null 2>&1
        cmd appops set "$pkg" RUN_ANY_IN_BACKGROUND ignore >/dev/null 2>&1
        echo "  -> Dikunci: $pkg"
    fi
done

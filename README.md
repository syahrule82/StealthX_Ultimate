# StealthX_Ultimate

Rangka kerja penalaan prestasi, penjimatan arus tunggu sedia (*Deep sleep*), dan pemusnah animasi antaramuka (**0.0x**) tanpa akses *root* untuk peranti Android berasaskan **ADB / Wireless Debugging**.

## Struktur Modul & Profil Peranti

* `core/nuke_animations.sh` — Teras pemusnah animasi sejagat (`0.0x`) merentas semua pengeluar.
* `stealthx_tune.sh` — Sekatan latar belakang (**Standby Bucket 45**), pengecualian aplikasi kewangan (**Bucket 5**), dan log audit (`audits/`).
* `profiles/poco_x5.sh` — **POCO X5 5G** (HyperOS — mengekalkan `com.miui.powerkeeper` dan `com.miui.screenrecorder`).
* `profiles/infinix_gt30_pro.sh` — **Infinix GT 30 Pro** (XOS — mengekalkan *Power Marathon*, *XArena*, dan perakam skrin).
* `profiles/oppo_a3x.sh`, `profiles/redmi_10c.sh`, `profiles/samsung_j4.sh`, `profiles/galaxy_j4.sh` — Profil khusus peranti.
* `profiles/universal_android.sh` — **Semua Peranti Android Lain-lain** (Sejagat).

## Cara Penggunaan (Terminal Chromebook / Linux)

1. Sambungkan peranti: `adb connect IP_TELEFON:PORT`
2. Jalankan profil: `bash profiles/poco_x5.sh` (atau `profiles/infinix_gt30_pro.sh` / `profiles/universal_android.sh`)
3. Putuskan sambungan (`adb disconnect`) dan matikan **Pilihan Pembangun** pada telefon demi keselamatan perbankan.

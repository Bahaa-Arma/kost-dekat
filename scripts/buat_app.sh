#!/usr/bin/env bash
# Membuat proyek Flutter di folder app/ dengan paket id.ac.telkomuniversity.kosdekat,
# lalu menyiapkan folder lib/, test/, assets/ sesuai docs/struktur-kode.md.
# Jalankan SEKALI dari root repo:  bash scripts/buat_app.sh
set -euo pipefail

cd "$(dirname "$0")/.."

if [ -f app/pubspec.yaml ]; then
  echo "app/pubspec.yaml sudah ada. Proyek Flutter sudah dibuat, skrip dibatalkan."
  exit 1
fi

echo "1/4 Membuat proyek Flutter..."
flutter create \
  --org id.ac.telkomuniversity \
  --project-name kosdekat \
  --platforms android \
  app

echo "2/4 Menyiapkan folder lib/ dan assets/..."
for d in lib/model lib/service lib/halaman lib/widget lib/tema lib/util \
         assets/fonts assets/icon assets/images; do
  mkdir -p "app/$d"
  touch "app/$d/.gitkeep"
done

echo "3/4 Mengatur AndroidManifest (label, INTERNET, cleartext)..."
MANIFEST=app/android/app/src/main/AndroidManifest.xml
if ! grep -q 'android.permission.INTERNET' "$MANIFEST"; then
  sed -i.bak 's|<application|<uses-permission android:name="android.permission.INTERNET"/>\n    <application android:usesCleartextTraffic="true"|' "$MANIFEST"
fi
sed -i.bak 's|android:label="kosdekat"|android:label="KosDekat"|' "$MANIFEST"
rm -f "$MANIFEST.bak"

echo "4/4 Hasil yang harus dicek:"
echo "--- applicationId (harus id.ac.telkomuniversity.kosdekat)"
grep -rn "applicationId" app/android/app/build.gradle* || true
echo "--- AndroidManifest"
grep -n 'INTERNET\|usesCleartextTraffic\|android:label' "$MANIFEST" || true

cat <<'SELESAI'

Selesai. Langkah berikutnya:
  1. Buka app/android/app/src/main/AndroidManifest.xml dan pastikan XML-nya rapi.
     (Pengguna macOS: bila baris izin tertulis "\n", rapikan manual.)
  2. cd app && flutter analyze      -> harus "No issues found!"
  3. flutter run                     -> ikon bertuliskan "KosDekat"
  4. git add -A && git commit -m "SCRUM-10 buat proyek Flutter app/"
SELESAI

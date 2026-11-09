#!/usr/bin/env bash
# Membuat zip pengumpulan LMS tanpa build/, .dart_tool/, android/.gradle/.
# Pakai git archive agar hanya file yang ter-commit yang masuk.
# Jalankan dari root repo setelah semua di-commit:  bash scripts/zip_pengumpulan.sh
set -euo pipefail

cd "$(dirname "$0")/.."

if [ -n "$(git status --porcelain)" ]; then
  echo "Masih ada perubahan yang belum di-commit. Commit dulu agar zip sama dengan repo."
  exit 1
fi

NAMA="kosdekat_kelompok06.zip"
git archive --format=zip --output="$NAMA" HEAD

echo "Dibuat: $NAMA"
echo "Memeriksa folder terlarang di dalam zip..."
if unzip -l "$NAMA" | grep -E "(^|/)(build|\.dart_tool)/|android/\.gradle/"; then
  echo "PERINGATAN: ada folder terlarang di zip!"
  exit 1
fi
echo "Aman: tidak ada build/, .dart_tool/, android/.gradle/."

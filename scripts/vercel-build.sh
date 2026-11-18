#!/usr/bin/env bash
set -euo pipefail

: "${API_BASE_URL:?Set API_BASE_URL in the Vercel project environment variables}"

flutter_version="3.50.0"
flutter_root="/tmp/flutter-sdk-${flutter_version}"
archive="/tmp/flutter-linux-${flutter_version}.tar.xz"

if ! command -v flutter >/dev/null 2>&1; then
  curl --fail --location --retry 3 \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${flutter_version}-stable.tar.xz" \
    --output "$archive"
  mkdir -p "$flutter_root"
  tar -xJf "$archive" -C "$flutter_root" --strip-components=1
  export PATH="$flutter_root/bin:$PATH"
fi

flutter config --enable-web
flutter pub get
flutter build web --release \
  --dart-define=ENV=production \
  --dart-define="API_BASE_URL=${API_BASE_URL%/}/"

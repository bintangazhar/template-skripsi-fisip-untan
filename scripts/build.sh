#!/bin/sh
# Builds the kuantitatif and kualitatif Typst Universe packages from shared sources.
#
# Usage: scripts/build.sh [build|install|uninstall|thumbnails|test]
#   build        assemble packages into dist/preview/<name>/<version>/
#   install      build, then symlink the packages into the Typst cache
#   uninstall    remove those symlinks
#   thumbnails   regenerate packages/*/thumbnail.png
#   test         typst init and compile each template in a temp dir
#
# Sources: src/ (code and logo, copied into each package), docs/penggunaan.md
# (README part shared by both), packages/<jenis>/ (the rest of each package).
set -eu

ROOT=$(cd "$(dirname "$0")/.." && pwd)
DIST="$ROOT/dist/preview"
if [ "$(uname -s)" = "Darwin" ]; then
  CACHE="$HOME/Library/Caches/typst/packages/preview"
else
  CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/typst/packages/preview"
fi
JENIS="kuantitatif kualitatif"

nilai() { # nilai <key> <typst.toml>: print the key's string value
  sed -n "s/^$1 *= *\"\(.*\)\"/\1/p" "$2" | head -n 1
}

build() {
  rm -rf "$ROOT/dist"
  for j in $JENIS; do
    pkg="$ROOT/packages/$j"
    nama=$(nilai name "$pkg/typst.toml")
    versi=$(nilai version "$pkg/typst.toml")
    out="$DIST/$nama/$versi"
    mkdir -p "$out"

    cp -R "$ROOT/src" "$out/src"
    cp -R "$pkg/template" "$out/template"
    cp "$pkg/typst.toml" "$out/typst.toml"
    cp "$ROOT/LICENSE" "$out/LICENSE"
    [ -f "$pkg/thumbnail.png" ] && cp "$pkg/thumbnail.png" "$out/thumbnail.png"

    cat "$pkg/README.md" "$ROOT/docs/penggunaan.md" \
      | sed "s/{{NAMA}}/$nama/g; s/{{VERSI}}/$versi/g" > "$out/README.md"

    echo "build: $nama $versi -> ${out#"$ROOT"/}"
  done
}

install_pkg() {
  build
  for j in $JENIS; do
    nama=$(nilai name "$ROOT/packages/$j/typst.toml")
    versi=$(nilai version "$ROOT/packages/$j/typst.toml")
    mkdir -p "$CACHE/$nama"
    ln -sfn "$DIST/$nama/$versi" "$CACHE/$nama/$versi"
    echo "install: $CACHE/$nama/$versi"
  done
}

uninstall_pkg() {
  for j in $JENIS; do
    nama=$(nilai name "$ROOT/packages/$j/typst.toml")
    versi=$(nilai version "$ROOT/packages/$j/typst.toml")
    rm -f "$CACHE/$nama/$versi"
    rmdir "$CACHE/$nama" 2>/dev/null || true
    echo "uninstall: $nama $versi"
  done
}

thumbnails() {
  install_pkg
  for j in $JENIS; do
    typst compile -f png --pages 1 --ppi 250 \
      "$ROOT/packages/$j/template/main.typ" "$ROOT/packages/$j/thumbnail.png"
    echo "thumbnail: packages/$j/thumbnail.png"
  done
  uninstall_pkg
  build
}

test_pkg() {
  install_pkg
  tmp=$(mktemp -d)
  status=0
  for j in $JENIS; do
    nama=$(nilai name "$ROOT/packages/$j/typst.toml")
    versi=$(nilai version "$ROOT/packages/$j/typst.toml")
    if typst init "@preview/$nama:$versi" "$tmp/$j" >/dev/null \
      && (cd "$tmp/$j" && typst compile main.typ out.pdf); then
      echo "test OK: $nama ($(pdfinfo "$tmp/$j/out.pdf" 2>/dev/null | sed -n 's/^Pages: *//p') halaman)"
    else
      echo "test GAGAL: $nama"
      status=1
    fi
  done
  rm -rf "$tmp"
  uninstall_pkg
  exit $status
}

case "${1:-build}" in
  build) build ;;
  install) install_pkg ;;
  uninstall) uninstall_pkg ;;
  thumbnails) thumbnails ;;
  test) test_pkg ;;
  *) echo "Perintah tidak dikenal: $1" >&2; exit 2 ;;
esac

#!/usr/bin/env bash
# Cross-compile the Windows app from Linux (x86_64-pc-windows-gnu via mingw-w64) and zip it
# into dist/. Needs: rustup target add x86_64-pc-windows-gnu, and the mingw-w64 C toolchain
# (Debian/Ubuntu: apt install gcc-mingw-w64-x86-64 binutils-mingw-w64-x86-64).
# Native Windows builds (MSVC) use scripts/package-windows.ps1 instead.
set -euo pipefail
cd "$(dirname "$0")/.."
target=x86_64-pc-windows-gnu
version=$(sed -n 's/^version = "\(.*\)"/\1/p' Cargo.toml | head -1)
rustup target add "$target" >/dev/null
cargo build --release --target "$target" -p market-desk
stage=dist/market-desk
rm -rf "$stage" && mkdir -p "$stage"
cp "target/$target/release/market-desk.exe" README.md NOTICE.md docs/DATA_SOURCES.md "$stage/"
# The GNU toolchain embeds the release profile's debug info in the exe; strip it.
x86_64-w64-mingw32-strip "$stage/market-desk.exe"
(cd dist && rm -f "market-desk-$version-windows-x64-gnu.zip" && zip -qr "market-desk-$version-windows-x64-gnu.zip" market-desk)
echo "dist/market-desk-$version-windows-x64-gnu.zip"

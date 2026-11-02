#!/usr/bin/env bash
# Cross-build Nousara Image for Windows x64 from Linux and wrap it in an NSIS installer.
# Needs: rustup target x86_64-pc-windows-gnu, mingw-w64, nsis (makensis).
set -euo pipefail
. "$(dirname "$0")/../env.sh"
TARGET=x86_64-pc-windows-gnu
cargo build --release --locked -p photocraft --target "$TARGET"
STAGE="$CARGO_TARGET_DIR/nousara-stage"
rm -rf "$STAGE" && mkdir -p "$STAGE"
cp "$CARGO_TARGET_DIR/$TARGET/release/photocraft.exe" "$STAGE/nousara-image.exe"
cp "$ROOT/assets/app-icon/photocraft.ico" "$STAGE/nousara.ico"
cp "$ROOT/LICENSE-MIT" "$ROOT/LICENSE-APACHE" "$ROOT/NOTICE" "$ROOT/ATTRIBUTION.md" "$STAGE/"
{ cat "$ROOT/NOTICE"; echo; echo; cat "$ROOT/LICENSE-MIT"; } > "$STAGE/LICENSE.txt"
mkdir -p "$STAGE/licenses"
find "$ROOT/assets" -name 'OFL-*.txt' -o -name 'LICENSE-*.txt' | while read -r f; do cp "$f" "$STAGE/licenses/"; done
makensis -V2 -DVERSION="$VERSION" -DSTAGE="$STAGE" -DOUTFILE="$ROOT/dist/Nousara-Image-Setup-$VERSION.exe" "$ROOT/packaging/nousara/installer.nsi"
echo "$ROOT/dist/Nousara-Image-Setup-$VERSION.exe"

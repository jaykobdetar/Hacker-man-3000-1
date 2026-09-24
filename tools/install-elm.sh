#!/usr/bin/env bash
# Installs the Elm 0.18 compiler (elm-make, elm-package, elm-reactor, elm-repl) into tools/elm/bin.
#
# The official download location used by `npm install elm@0.18` no longer exists, so the
# binaries come from https://github.com/lydell/elm-old-binaries and are checked against
# pinned SHA-256 hashes. Only x86-64 builds exist (Apple Silicon Macs run them under Rosetta 2).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/tools/elm"
BASE_URL="https://github.com/lydell/elm-old-binaries/releases/download/main"

case "$(uname -s)" in
    Linux)  asset="0.18.0-linux-x64.tar.gz";  sha256="6885046e3c17517c080e02d121e8c0b8298362b256d827adcb46e9cb7138d71e" ;;
    Darwin) asset="0.18.0-darwin-x64.tar.gz"; sha256="f4b9e3b4c398e74303bc09a3dc1753b527f35cbb5fcb3eb8d754f087d0b5e9f6" ;;
    *) echo "Unsupported OS: $(uname -s). Use Linux, macOS or WSL." >&2; exit 1 ;;
esac

if [ -x "$DEST/bin/elm-make" ]; then
    echo "Elm 0.18 already installed in $DEST/bin"
    exit 0
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

curl -fsSL -o "$tmp/elm.tar.gz" "$BASE_URL/$asset"
if command -v sha256sum > /dev/null; then
    actual="$(sha256sum "$tmp/elm.tar.gz" | cut -d' ' -f1)"
else
    actual="$(shasum -a 256 "$tmp/elm.tar.gz" | cut -d' ' -f1)"
fi
if [ "$actual" != "$sha256" ]; then
    echo "Checksum mismatch for $asset (got $actual)" >&2
    exit 1
fi

tar -xzf "$tmp/elm.tar.gz" -C "$tmp"
mkdir -p "$DEST/bin"
cp "$tmp"/dist_binaries/* "$DEST/bin/"
chmod +x "$DEST"/bin/*
echo "Installed Elm 0.18 into $DEST/bin"

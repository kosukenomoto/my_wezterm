#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <BIN_NAME> [--release]" >&2
  exit 1
fi

BIN="$1"; shift || true
SAMPLE="$(dirname "$0")/../samples/${BIN}.in"

if [ ! -f "$SAMPLE" ]; then
  echo "Sample not found: samples/${BIN}.in" >&2
  echo "Available samples:" >&2
  ls -1 "$(dirname "$0")/../samples" | sed 's/\.in$//' >&2
  exit 2
fi

cd "$(dirname "$0")/.."
cat "$SAMPLE" | cargo run --quiet --bin "$BIN" "$@"


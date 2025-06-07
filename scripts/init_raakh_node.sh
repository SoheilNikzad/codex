#!/usr/bin/env bash
# Helper script to initialize a local RAAKH node.
set -e

REPO_URL="https://github.com/maticnetwork/bor"
TARGET_DIR="bor"
GENESIS_FILE="$(dirname "$0")/../raakh/genesis.json"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Cloning Polygon bor repository..."
  git clone --depth 1 "$REPO_URL" "$TARGET_DIR"
fi

cd "$TARGET_DIR"

echo "Building bor..."
make bor || true

cd ..

./bor/build/bin/geth --datadir node init "$GENESIS_FILE"

cat <<MSG
Initialization complete. To start the node, run:

  ./bor/build/bin/geth \
    --datadir node \
    --networkid 1337 \
    --http --http.addr 0.0.0.0 --http.port 8545
MSG

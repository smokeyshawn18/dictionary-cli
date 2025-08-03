#!/bin/bash

set -e

REPO="smokeyshawn18/dictionary-cli"
VERSION="latest"
APP="define"
OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

if [[ "$ARCH" == "x86_64" ]]; then
  ARCH="amd64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
  ARCH="arm64"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

BINARY="${APP}-${OS}-${ARCH}.zip"
URL="https://github.com/$REPO/releases/$VERSION/download/$BINARY"

echo "📦 Downloading $BINARY..."
curl -sSL -o "$BINARY" "$URL"

echo "📂 Unzipping..."
unzip "$BINARY" -d /usr/local/bin/
chmod +x /usr/local/bin/$APP
rm "$BINARY"

echo "✅ Installed: $APP"
echo "Run: $APP <word>"

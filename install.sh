#!/bin/bash

set -e

REPO="smokeyshawn18/dictionary-cli"
VERSION="v1.0.0"   # Replace with your actual release tag
BINARY_NAME="define"

echo "📦 Installing $BINARY_NAME from $REPO..."

# Detect OS and ARCH
OS=$(uname -s)
ARCH=$(uname -m)

case "$OS" in
  "Linux")
    PLATFORM="linux"
    ;;
  "Darwin")
    PLATFORM="darwin"
    ;;
  *)
    echo "❌ Unsupported OS: $OS"
    echo "Please download manually from: https://github.com/$REPO/releases"
    exit 1
    ;;
esac

case "$ARCH" in
  "x86_64")
    ARCH="amd64"
    ;;
  "arm64" | "aarch64")
    ARCH="arm64"
    ;;
  *)
    echo "❌ Unsupported architecture: $ARCH"
    echo "Please download manually from: https://github.com/$REPO/releases"
    exit 1
    ;;
esac

ZIP_NAME="dictionary-cli-$PLATFORM-$ARCH.zip"
BIN_NAME="dictionary-cli-$PLATFORM-$ARCH"

echo "➡️ Downloading $ZIP_NAME..."
curl -LO "https://github.com/$REPO/releases/download/$VERSION/$ZIP_NAME"

echo "📂 Unzipping..."
unzip -o "$ZIP_NAME"

echo "🔧 Making executable..."
chmod +x "$BIN_NAME"

echo "🚚 Moving to /usr/local/bin/$BINARY_NAME"
sudo mv "$BIN_NAME" /usr/local/bin/$BINARY_NAME

# Optional symlink
echo "🔗 Linking to define"
sudo ln -sf /usr/local/bin/$BINARY_NAME /usr/local/bin/define

echo "✅ Installed! Try running: define hello"

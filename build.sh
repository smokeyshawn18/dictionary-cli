#!/bin/bash

APP_NAME="define"
DIST="dist"
mkdir -p $DIST

# Clean previous builds
rm -f $DIST/*

# Build for Linux
GOOS=linux GOARCH=amd64 go build -o $DIST/${APP_NAME}-linux-amd64 ./cmd
GOOS=linux GOARCH=arm64 go build -o $DIST/${APP_NAME}-linux-arm64 ./cmd

# Build for macOS
GOOS=darwin GOARCH=amd64 go build -o $DIST/${APP_NAME}-darwin-amd64 ./cmd
GOOS=darwin GOARCH=arm64 go build -o $DIST/${APP_NAME}-darwin-arm64 ./cmd

# Build for Windows
GOOS=windows GOARCH=amd64 go build -o $DIST/${APP_NAME}-windows-amd64.exe ./cmd
GOOS=windows GOARCH=arm64 go build -o $DIST/${APP_NAME}-windows-arm64.exe ./cmd

# Zip them all
cd $DIST
for f in *; do
  zip "${f}.zip" "$f"
done
cd ..
echo "✅ Build complete."

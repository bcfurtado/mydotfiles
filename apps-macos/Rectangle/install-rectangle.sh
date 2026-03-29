#!/usr/bin/env bash
set -eu

GREEN='\033[0;32m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
RECTANGLE_DIR=~/Library/Application\ Support/Rectangle

info "Importing Rectangle settings..."
mkdir -p "$RECTANGLE_DIR"
cp -f "${SCRIPT_DIR}/RectangleConfig.json" "$RECTANGLE_DIR/RectangleConfig.json"

info "Rectangle settings imported. Restart Rectangle to apply."

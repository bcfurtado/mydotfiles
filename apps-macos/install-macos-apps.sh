#!/usr/bin/env bash
set -eu

GREEN='\033[0;32m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }

cd "$(dirname "$0")"

# Apply macOS defaults
info "Applying macOS defaults..."
./install-macos-preferences.sh

# Configure iTerm2
info "Configuring iTerm2..."
./iTerm2/install-iterm2-theme.sh

# Configure Rectangle
info "Configuring Rectangle..."
./Rectangle/install-rectangle.sh

#!/usr/bin/env bash

set -eu

GREEN='\033[0;32m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }

# Install brew packages
info "Installing brew packages..."
brew bundle install --file=Brewfile

# Create symlinks and extra files
info "Creating symlinks and extra files..."
./install-dotfiles.sh

# Apply macOS defaults
info "Applying macOS defaults..."
./install-macos-preferences.sh

info "Done"

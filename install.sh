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
./apps/install-dotfiles.sh

# Configure macOS apps and preferences
info "Configuring macOS apps..."
./apps-macos/install-macos-apps.sh

info "Done"

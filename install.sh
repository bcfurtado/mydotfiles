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

# Configure iTerm2
info "Configuring iTerm2..."
./apps/iTerm2/install-iterm2-theme.sh

# Configure Rectangle
info "Configuring Rectangle..."
./apps/Rectangle/install-rectangle.sh

info "Done"

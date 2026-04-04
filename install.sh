#!/usr/bin/env bash
set -eu

GREEN='\033[0;32m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }

# Install brew packages
info "Installing brew packages..."
brew bundle install --file=Brewfile

# Install fzf-tab (fzf-based tab completion for zsh)
info "Installing fzf-tab..."
FZF_TAB_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab"
if [ ! -d "$FZF_TAB_DIR" ]; then
  git clone --quiet https://github.com/Aloxaf/fzf-tab "$FZF_TAB_DIR"
else
  info "fzf-tab already installed, skipping..."
fi

# Create symlinks and extra files
info "Creating symlinks and extra files..."
./apps/install-dotfiles.sh

# Configure macOS apps and preferences
info "Configuring macOS apps..."
./apps-macos/install-macos-apps.sh

info "Done"

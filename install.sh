#!/usr/bin/env bash
set -eu

GREEN='\033[0;32m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }

detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)  echo "linux" ;;
    *)      echo "unknown" ;;
  esac
}

OS=$(detect_os)

# Install packages
if [ "$OS" = "macos" ]; then
  info "Installing brew packages..."
  brew bundle install --file=Brewfile
elif [ "$OS" = "linux" ]; then
  info "Installing Linux packages..."
  ./apps-linux/install-linux-packages.sh
else
  echo "Unsupported OS: $(uname -s)" && exit 1
fi

# Create symlinks and extra files
info "Creating symlinks and extra files..."
./apps/install-dotfiles.sh

# Configure macOS apps and preferences
if [ "$OS" = "macos" ]; then
  info "Configuring macOS apps..."
  ./apps-macos/install-macos-apps.sh
fi

info "Done"

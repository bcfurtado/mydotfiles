#!/usr/bin/env bash
#
# This script should be run via curl:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/bcfurtado/mydotfiles/master/tools/setup.sh)"
# or via wget:
#   bash -c "$(wget -qO- https://raw.githubusercontent.com/bcfurtado/mydotfiles/master/tools/setup.sh)"
#
# As an alternative, you can first download the script and run it afterwards:
#   curl -fsSL https://raw.githubusercontent.com/bcfurtado/mydotfiles/master/tools/setup.sh -o setup.sh
#   bash setup.sh
#
set -eu

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }
warn() { echo -e "${YELLOW}$1${NC}"; }

REPO_DIR=~/projects/github.com/bcfurtado/mydotfiles

mkdir -p ~/projects/github.com/bcfurtado

# Clone the repository using SSH if keys are configured on GitHub, otherwise HTTPS.
# ssh -T returns exit code 1 on successful auth and 255 on failure.
clone_repository() {
  USE_SSH=$(ssh -T git@github.com 2>/dev/null; echo $?)
  if [ "$USE_SSH" -eq 1 ]; then
    info "Using SSH to clone repository"
    git clone --quiet "git@github.com:bcfurtado/mydotfiles.git" "$REPO_DIR"
  else
    warn "Using HTTPS to clone repository"
    git clone --quiet "https://github.com/bcfurtado/mydotfiles.git" "$REPO_DIR"
  fi
}

if [ ! -d "$REPO_DIR" ]; then
  info "Cloning repository..."
  clone_repository
else
  warn "Repository already exists at $REPO_DIR. Skipping..."
fi

cd "$REPO_DIR"

# Install brew packages
info "Installing brew packages..."
brew bundle install --file=Brewfile

# Create symlinks and extra files
info "Creating symlinks and extra files..."
./install.sh

# Apply macOS defaults
info "Applying macOS defaults..."
./macos.sh

info "Setup complete!"

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

# Clone a GitHub repository using SSH if keys are configured, otherwise HTTPS.
# Usage: clone_repository "owner/repo" "target_dir"
# ssh -T returns exit code 1 on successful auth and 255 on failure.
clone_repository() {
  local repo=$1
  local target=$2
  USE_SSH=$(ssh -T git@github.com 2>/dev/null; echo $?)
  if [ "$USE_SSH" -eq 1 ]; then
    info "Using SSH to clone $repo"
    git clone --quiet "git@github.com:${repo}.git" "$target"
  else
    warn "Using HTTPS to clone $repo"
    git clone --quiet "https://github.com/${repo}.git" "$target"
  fi
}

if [ ! -d "$REPO_DIR" ]; then
  info "Cloning repository..."
  clone_repository "bcfurtado/mydotfiles" "$REPO_DIR"
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

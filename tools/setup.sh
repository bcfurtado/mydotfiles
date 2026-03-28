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

WORKSPACE=~/projects/github.com

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

# Set up a GitHub repository. Clones it if it doesn't exist, skips otherwise.
# Usage: setup_repository "owner/repo"
setup_repository() {
  local repo=$1
  local target="${WORKSPACE}/${repo}"

  if [ -d "$target" ]; then
    warn "Repository already exists at $target. Skipping..."
    return
  fi

  mkdir -p "$(dirname "$target")"
  info "Cloning ${repo}..."
  clone_repository "$repo" "$target"
}

# Set up mydotfiles repo
read -rp "Do you want to setup 'bcfurtado/mydotfiles'? (y/n) " answer
if [ "$answer" = "y" ]; then
  setup_repository "bcfurtado/mydotfiles"
  pushd "${WORKSPACE}/bcfurtado/mydotfiles"
  ./install.sh
  popd
fi

# Set up emacs repo
read -rp "Do you want to setup 'bcfurtado/.emacs.d'? (y/n) " answer
if [ "$answer" = "y" ]; then
  setup_repository "bcfurtado/.emacs.d"
  pushd "${WORKSPACE}/bcfurtado/.emacs.d"
  ./install.sh
  popd
fi

# Set up tmux repo
read -rp "Do you want to setup 'bcfurtado/.tmux'? (y/n) " answer
if [ "$answer" = "y" ]; then
  setup_repository "bcfurtado/.tmux"
  pushd "${WORKSPACE}/bcfurtado/.tmux"
  ln -s -f ~/projects/github.com/bcfurtado/.tmux/.tmux.conf ~/.tmux.conf
  ln -s -f ~/projects/github.com/bcfurtado/.tmux/.tmux.conf.bruno.local ~/.tmux.conf.local
  popd
fi

info "Setup complete!"

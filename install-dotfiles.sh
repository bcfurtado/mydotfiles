#!/usr/bin/env bash
set -eu

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
STOW_PACKAGES="git zsh vim k9s"

stow -v -t "$HOME" --dir="$DOTFILES_DIR" --restow $STOW_PACKAGES

# Create extra files for machine-specific overrides
create_if_missing() {
  local file="$1"
  if [ ! -f "$file" ]; then
    touch "$file"
    echo "Created $file"
  fi
}

create_if_missing ~/.gitconfig-extra
create_if_missing ~/.zshrc-extra

#!/usr/bin/env bash
set -eu

BACKUP_DIR=~/dotfiles-backup/$(date +%Y%m%d%H%M%S)

link() {
  local src=$(realpath "$1")
  local dst="$2"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "Backed up $dst to $BACKUP_DIR/"
  fi
  ln -s -f "$src" "$dst"
}

create_if_missing() {
  local file="$1"
  if [ ! -f "$file" ]; then
    touch "$file"
    echo "Created $file"
  fi
}

# Create symbolic links
link ./.gitconfig ~/.gitconfig
link ./.gitconfig-personal ~/.gitconfig-personal

link ./.zlogin ~/.zlogin
link ./.zprofile ~/.zprofile
link ./.zshrc ~/.zshrc

link ./vim/.vimrc ~/.vimrc

# Create extra files for machine-specific overrides
create_if_missing ~/.gitconfig-extra
create_if_missing ~/.zshrc-extra

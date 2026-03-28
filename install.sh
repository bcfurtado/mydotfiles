#!/usr/bin/env bash

BACKUP_DIR=~/dotfiles-backup/$(date +%Y%m%d%H%M%S)

link() {
  local src=$(realpath "$1")
  local dst="$2"
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "Backed up $dst to $BACKUP_DIR/"
  fi
  ln -s "$src" "$dst"
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
link ./vim/.vimrc ~/.vimrc
link ./.zshrc ~/.zshrc
link ./.zshrc ~/.zlogin

# Create extra files for machine-specific overrides
create_if_missing ~/.gitconfig-extra
create_if_missing ~/.zshrc-extra

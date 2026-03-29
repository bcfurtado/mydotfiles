#!/usr/bin/env bash
set -eu

cd "$(dirname "$0")"
STOW_PACKAGES=(
  atuin
  direnv
  git
  k9s
  vim
  zsh
)
BACKUP_DIR=~/dotfiles-backup/$(date +%Y%m%d%H%M%S)

# Backup existing files that would be overwritten by stow
backup_if_exists() {
  local file="$1"
  if [ -e "$file" ] && [ ! -L "$file" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$file" "$BACKUP_DIR/"
    echo "Backed up $file to $BACKUP_DIR/"
  elif [ -L "$file" ]; then
    rm "$file"
  fi
}

for package in ${STOW_PACKAGES[@]}; do
  while IFS= read -r -d '' file; do
    target="$HOME/${file#"$package"/}"
    backup_if_exists "$target"
  done < <(find "$package" -type f -print0)
done

stow -v -t "$HOME" --dir=. --restow ${STOW_PACKAGES[@]}

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

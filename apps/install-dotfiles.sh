#!/usr/bin/env bash
set -eu

cd "$(dirname "$0")"
STOW_PACKAGES=(
  atuin
  bat
  direnv
  git
  k9s
  ripgrep
  vim
  zsh
)
BACKUP_DIR=~/dotfiles-backup/$(date +%Y%m%d%H%M%S)

# Backup existing files that would be overwritten by stow
STOW_DIR="$(pwd)"

backup_if_exists() {
  local file="$1"
  local real_path
  real_path="$(realpath "$file" 2>/dev/null || true)"

  # Skip files that resolve into the stow directory (already managed by stow)
  if [[ -n "$real_path" && "$real_path" == "$STOW_DIR"* ]]; then
    return
  fi

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
  done < <(find "$package" -type f -not -name '.stow-local-ignore' -print0)
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

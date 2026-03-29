#!/usr/bin/env bash
set -eu

GREEN='\033[0;32m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DYNAMIC_PROFILES_DIR=~/Library/Application\ Support/iTerm2/DynamicProfiles

info "Installing iTerm2 dynamic profile with Snazzy colors..."
mkdir -p "$DYNAMIC_PROFILES_DIR"
cp -f "${SCRIPT_DIR}/snazzy-profile.json" "$DYNAMIC_PROFILES_DIR/snazzy-profile.json"

info "Setting Snazzy profile as default..."
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "6C5A0312-0145-4708-BEC4-AB0411DAA00A"

info "Setting Minimal theme..."
defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 5

info "iTerm2 theme applied. Changes take effect immediately if iTerm2 is running."

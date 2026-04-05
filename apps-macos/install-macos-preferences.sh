#!/usr/bin/env bash
set -eu

GREEN='\033[0;32m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }

PLIST=~/Library/Preferences/com.apple.symbolichotkeys.plist

set_hotkey() {
  /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:${1}:enabled false" "$PLIST" 2>/dev/null
}

add_hotkey() {
  /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:${1}:enabled bool false" "$PLIST"
}

# Disable a symbolic hotkey by ID. Creates the entry if it doesn't exist.
disable_hotkey() {
  set_hotkey "$1" || add_hotkey "$1"
}

info "Using F1, F2, etc. keys as standard function keys"
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

info "Enabling keyboard navigation (Tab to move focus between controls)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

info "Disabling Turn Dock hiding on/off (Cmd+Option+D)"
disable_hotkey 52

info "Disabling Select the previous input source (Ctrl+Space)"
disable_hotkey 60

info "Disabling Select next source in Input menu (Ctrl+Option+Space)"
disable_hotkey 61

info "Disabling Screenshot and recording options (Cmd+Shift+5)"
disable_hotkey 184

info "Setting key repeat rate to fastest"
defaults write NSGlobalDomain KeyRepeat -int 3

info "Setting delay until repeat to shortest"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

info "Applying settings..."
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
killall Dock
killall Finder

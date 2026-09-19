#!/usr/bin/env bash
# Claude Code status line - inspired by the Pure prompt style
# Receives JSON via stdin with session/context information

input=$(cat)

# Directory: use cwd from JSON
cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
# Shorten home directory to ~.
# Deliberately not ${cwd/#$home/~}: bash 5 tilde-expands the replacement back
# into $HOME (making it a no-op) while bash 3.2 does not, and escaping the
# tilde flips which version breaks. case/# behaves the same everywhere.
home="$HOME"
case "$cwd" in
  "$home")   short_cwd="~" ;;
  "$home"/*) short_cwd="~${cwd#"$home"}" ;;
  *)         short_cwd="$cwd" ;;
esac

# Git branch (skip optional locks to avoid conflicts)
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" -c core.fsmonitor=false symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" -c core.fsmonitor=false rev-parse --short HEAD 2>/dev/null)
fi

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Context window usage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Account: which config dir this session is using. Work (~/.claude) is the
# default and stays unbadged; anything else is a second account.
config_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
account="${config_dir##*/}"
account="${account#.claude-}"
[ "$account" = ".claude" ] && account=""

# Build the status line using ANSI colors (dimmed-friendly)
# Format: [account]  ~/path/to/dir  branch  model  ctx:XX%
# Reverse video for the badge: unmistakable, and readable regardless of theme.
if [ -n "$account" ]; then
  printf "\033[7m %s \033[0m  " "$account"
fi

printf "\033[34m%s\033[0m" "$short_cwd"

if [ -n "$git_branch" ]; then
  printf "  \033[35m%s\033[0m" "$git_branch"
fi

if [ -n "$model" ]; then
  printf "  \033[36m%s\033[0m" "$model"
fi

if [ -n "$used_pct" ]; then
  printf "  \033[33mctx:%.0f%%\033[0m" "$used_pct"
fi

printf "\n"

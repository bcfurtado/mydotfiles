# Claude Code accounts
# https://code.claude.com/docs/en/claude-directory
#
# Two subscriptions, one machine. CLAUDE_CONFIG_DIR keys its own macOS Keychain
# entry, so each config dir holds an independent login and both stay signed in.
#
# Work is the default: plain `claude` leaves CLAUDE_CONFIG_DIR unset and uses
# ~/.claude exactly as before. Both functions below pass the variable as a
# one-shot prefix, so the shell's own environment is never modified.

CLAUDE_PERSONAL_DIR="$HOME/.claude-personal"

# Personal account.
claude-personal() {
  CLAUDE_CONFIG_DIR="$CLAUDE_PERSONAL_DIR" command claude "$@"
}

# Work account. Same as plain `claude`, unless CLAUDE_CONFIG_DIR has leaked
# into the environment somehow.
claude-work() {
  env -u CLAUDE_CONFIG_DIR command claude "$@"
}

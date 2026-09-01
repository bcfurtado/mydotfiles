# Zoxide
# https://github.com/ajeetdsouza/zoxide
if [[ "$CLAUDECODE" != "1" ]] && (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh --cmd cd)"
fi

# Zoxide
# https://github.com/ajeetdsouza/zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh --cmd cd)"
fi

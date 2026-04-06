# Atuin
# https://github.com/atuinsh/atuin
export PATH="$HOME/.atuin/bin:$PATH"
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh)"
fi

# Oh My Zsh
# Options below are set after oh-my-zsh to override its defaults
# https://github.com/ohmyzsh/ohmyzsh
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  direnv
  emacs
  fzf-tab
  git
  k9s
  kubectl
  python
)

if [ -d "$ZSH" ]; then
  ZSH_THEME="robbyrussell"
  source $ZSH/oh-my-zsh.sh
fi

# Pure
# https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
if typeset -f prompt_pure_setup > /dev/null; then
  prompt pure
else
  echo "warning: Pure prompt not loaded"
fi

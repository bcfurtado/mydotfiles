# Oh My Zsh
# Options below are set after oh-my-zsh to override its defaults
# https://github.com/ohmyzsh/ohmyzsh
export ZSH="${XDG_DATA_HOME:-${HOME}/.local/share}/ohmyzsh"
export PURE_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/ohmyzsh/custom/plugins/pure"

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
[ -d $PURE_DIR/.git ] && fpath+=($PURE_DIR)
autoload -U promptinit; promptinit
if typeset -f prompt_pure_setup > /dev/null; then
  prompt pure
else
  echo "warning: Pure prompt not loaded"
fi

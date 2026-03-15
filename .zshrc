# History
setopt HIST_IGNORE_SPACE     # don't save commands starting with space
setopt HIST_IGNORE_DUPS      # ignore consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS  # remove older duplicates
setopt SHARE_HISTORY         # share history across terminals
setopt INC_APPEND_HISTORY    # write history immediately

# Aliases
alias cat="bat -p --paging=never"  # use bat as a drop-in cat replacement (no paging)
alias k="kubectl"
alias ll='ls -alF'
alias tf="terraform"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
if [ -d "$ZSH" ]; then
  ZSH_THEME="robbyrussell"
  plugins=(git emacs python direnv kubectl k9s)
  source $ZSH/oh-my-zsh.sh
fi


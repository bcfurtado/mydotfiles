# Oh My Zsh
# Options below are set after oh-my-zsh to override its defaults
# https://github.com/ohmyzsh/ohmyzsh
export ZSH="$HOME/.oh-my-zsh"
if [ -d "$ZSH" ]; then
  ZSH_THEME="robbyrussell"
  plugins=(git emacs python direnv kubectl k9s fzf-tab)
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

# # make: show targets before files
zstyle ':completion:*:*:make:*' tag-order targets variables files
# # kill: do not wrap long process and preview it at the bottom of the screen
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3

# History
setopt HIST_IGNORE_SPACE     # don't save commands starting with space
setopt HIST_IGNORE_DUPS      # ignore consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS  # remove older duplicates
setopt SHARE_HISTORY         # share history across terminals
setopt INC_APPEND_HISTORY    # write history immediately

# Aliases
alias cat="bat -p --paging=never"  # use bat as a drop-in cat replacement (no paging)
alias k="kubectl"
alias ll="ls -alFh"
alias tf="terraform"
alias openports="lsof -iTCP -sTCP:LISTEN -P -n | ov --column-rainbow --column-width --header 1"
alias csv="ov --view-mode csv --wrap=false"

# Zoxide
# https://github.com/ajeetdsouza/zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh --cmd cd)"
fi

# fzf
# https://github.com/junegunn/fzf
if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
  # Setting fd as the default source for fzf
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --strip-cwd-prefix --exclude .git --exclude node_modules --exclude target"
  # To apply the command to CTRL-T as well
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  # Preview file content using bat (https://github.com/sharkdp/bat)
  export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi


# Atuin
# https://github.com/atuinsh
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh)"
fi

# ripgrep
# https://github.com/BurntSushi/ripgrep
if (( $+commands[rg] )); then
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
fi

# Local overrides
if [ -f ~/.zshrc-extra ]; then
  source ~/.zshrc-extra
fi

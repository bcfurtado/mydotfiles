# fzf
# https://github.com/junegunn/fzf

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --strip-cwd-prefix --exclude .git --exclude node_modules --exclude target"
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Preview file content using bat
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi

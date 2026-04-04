# make: show targets before files
zstyle ':completion:*:*:make:*' tag-order targets variables files

# kill: do not wrap long process and preview it at the bottom of the screen
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3

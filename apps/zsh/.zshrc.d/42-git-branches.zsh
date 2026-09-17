# gbp — fuzzy-pick a git branch and open `git lg` for it.
# Enter:    open git lg <branch>
# ctrl-r:   reload list including remote-tracking branches
# ctrl-/:   toggle preview window

# oh-my-zsh's git plugin aliases `gb` to `git branch`; drop it so we can define the function.
unalias gb 2>/dev/null

gbp() {
  local format='%(color:red)%(objectname:short)%(color:reset) %(color:yellow)%(refname:short)%(color:reset)'
  local local_cmd="git for-each-ref --sort=-committerdate refs/heads/ --format='$format' --color=always"
  local all_cmd="git for-each-ref --sort=-committerdate refs/heads/ refs/remotes/ --format='$format' --color=always"

  local selection
  selection=$(eval "$local_cmd" | fzf \
    --ansi \
    --no-sort \
    --header 'enter: git lg · ctrl-r: include remotes · ctrl-/: toggle preview' \
    --preview 'git lg2 --color=always -n 30 $(echo {} | awk "{print \$2}")' \
    --preview-window=right,60%,wrap \
    --bind "ctrl-r:reload($all_cmd)" \
    --bind 'ctrl-/:change-preview-window(down|hidden|)') || return 0

  local branch
  branch=$(echo "$selection" | awk '{print $2}')
  [[ -n "$branch" ]] && git lg "$branch"
}

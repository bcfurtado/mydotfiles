alias cat="bat -p --paging=never"  # use bat as a drop-in cat replacement (no paging)
alias csv="ov --view-mode csv --wrap=false"
alias k="kubectl"
alias ll="ls -alFh"
alias openports="lsof -iTCP -sTCP:LISTEN -P -n | ov --column-rainbow --column-width --header 1"
alias tf="terraform"
alias dps="docker ps"

if ! command -v docker >/dev/null 2>&1; then
  alias lazydocker='DOCKER_HOST="unix://$(podman machine inspect --format "{{.ConnectionInfo.PodmanSocket.Path}}")" command lazydocker'
fi

alias git-show-merged-branches='git branch --merged | grep -Ev "(^\*|^\+|master|main|dev)"'
alias git-clean-local-branches='git branch --merged | grep -Ev "(^\*|^\+|master|main|dev)" | xargs --no-run-if-empty git branch -d'

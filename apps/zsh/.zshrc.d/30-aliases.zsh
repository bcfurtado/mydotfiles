alias cat="bat -p --paging=never"  # use bat as a drop-in cat replacement (no paging)
alias csv="ov --view-mode csv --wrap=false"
alias k="kubectl"
alias ll="ls -alFh"
alias openports="lsof -iTCP -sTCP:LISTEN -P -n | ov --column-rainbow --column-width --header 1"
alias tf="terraform"

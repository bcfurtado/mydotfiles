# killport [port]
# Kill a process listening on a TCP port.
#
# Usage:
#   killport 8080   Kill the process listening on port 8080 directly.
#   killport        Open an fzf picker listing all listening ports.
#                   The preview pane shows full process details (pid, user,
#                   cpu, mem, command) for the currently selected entry.
#                   Press Enter to select and kill; Esc to cancel.
#
# Dependencies: lsof, fzf, awk
killport() {
  local pid
  if [[ -n $1 ]]; then
    # -t: output only PIDs (no headers), making it safe to assign directly
    pid=$(lsof -iTCP:$1 -sTCP:LISTEN -P -n -t)
    if [[ -z $pid ]]; then
      echo "No process listening on port $1"
      return 1
    fi
  else
    # -P: show port numbers instead of service names (e.g. 8080 not http-alt)
    # -n: skip hostname resolution for speed
    # {2} in --preview refers to the 2nd field (PID) of the selected fzf line
    pid=$(lsof -iTCP -sTCP:LISTEN -P -n | fzf \
      --header-lines=1 \
      --layout=reverse \
      --prompt='kill port> ' \
      --preview 'ps -p {2} -o pid,user,%cpu,%mem,command 2>/dev/null' \
      --preview-window=down:4:wrap \
      | awk '{print $2}')
  fi
  # $pid is empty when the user cancels fzf (Esc)
  [[ -z $pid ]] && return 1
  kill $pid && echo "Killed PID $pid"
}

# _killport: zsh tab completion for killport.
# Lists all listening TCP ports using lsof, showing the full lsof line as the
# display string in fzf-tab while completing only the port number.
# compadd -d: display strings shown in fzf-tab (full lsof line)
# compadd -a: actual completion values inserted (port numbers only)
_killport() {
  local -a ports displays
  while IFS= read -r line; do
    # Field 9 of lsof output is NAME (e.g. "*:8080"); extract trailing port number
    local port=$(echo $line | awk '{print $9}' | grep -oE '[0-9]+$')
    ports+=("$port")
    displays+=("$line")
  done < <(lsof -iTCP -sTCP:LISTEN -P -n | tail -n +2)
  compadd -d displays -a ports
}

# Bind _killport as the completion function for killport
compdef _killport killport

# fzf-tab: show full ps output for the selected port in the preview pane.
# $word is the current completion word (the port number being completed).
zstyle ':fzf-tab:complete:killport:*' fzf-preview \
  'ps -p $(lsof -iTCP:$word -sTCP:LISTEN -P -n -t 2>/dev/null) -o pid,user,%cpu,%mem,command 2>/dev/null'

# fzf-tab: capture lsof column header once at shell startup to use as fzf header.
# --header-lines=1 is not supported by fzf-tab, so the header is passed as a
# static string via --header.
zstyle ':fzf-tab:complete:killport:*' fzf-flags \
  '--preview-window=down:4:wrap' \
  "--header=$(lsof -iTCP -sTCP:LISTEN -P -n 2>/dev/null | head -1)"

# fzf-tab: use 'accept' (not 'accept-line') so selecting a port fills it in
# on the command line without immediately executing the command.
zstyle ':fzf-tab:complete:killport:*' fzf-bindings 'enter:accept'

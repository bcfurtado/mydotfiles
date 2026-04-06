# Start tmux on login; attach to existing session or create a new one
if [ -z "$TMUX" ]; then
  tmux attach || tmux new
fi

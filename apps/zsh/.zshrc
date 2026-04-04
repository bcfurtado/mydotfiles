# Sources all *.zsh files in ~/.zshrc.d/ in alphanumeric order.
# Add new configuration by dropping a numbered file into ~/.zshrc.d/
# (N) is a zsh glob qualifier that suppresses errors if the directory is empty.
for f in "$HOME/.zshrc.d/"*.zsh(N); do source "$f"; done

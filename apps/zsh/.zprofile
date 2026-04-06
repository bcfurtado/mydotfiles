# Homebrew (macOS only)
if [[ "$(uname -s)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# User-local binaries (needed on Linux for tools installed to ~/.local/bin)
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Go
# https://go.dev
# macOS gets the toolchain from Homebrew (already on PATH); Linux unpacks it
# into ~/.local/go, which is not on PATH by default.
if [[ -d "$HOME/.local/go/bin" && ":$PATH:" != *":$HOME/.local/go/bin:"* ]]; then
  export PATH="$HOME/.local/go/bin:$PATH"
fi

# `go install` writes binaries to $GOPATH/bin (GOPATH defaults to ~/go).
export GOPATH="${GOPATH:-$HOME/go}"
if [[ ":$PATH:" != *":$GOPATH/bin:"* ]]; then
  export PATH="$GOPATH/bin:$PATH"
fi

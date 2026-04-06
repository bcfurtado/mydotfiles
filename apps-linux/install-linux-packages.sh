#!/usr/bin/env bash
set -eu

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

info() { echo -e "${GREEN}$1${NC}"; }
warn() { echo -e "${YELLOW}$1${NC}"; }

ARCH=$(dpkg --print-architecture)  # amd64, arm64
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# Download a single binary from a URL and place it in BIN_DIR.
install_gh_binary() {
  local name=$1
  local url=$2
  if [ -f "$BIN_DIR/$name" ]; then
    info "$name already installed, skipping..."
    return
  fi
  info "Installing $name..."
  curl -fsSL "$url" -o "$BIN_DIR/$name"
  chmod +x "$BIN_DIR/$name"
}

# Download a .tar.gz, extract one binary from it, and place it in BIN_DIR.
# binary_in_archive is the path inside the archive, e.g. "k9s" or "bin/hurl".
install_gh_tarball() {
  local name=$1
  local url=$2
  local binary_in_archive=$3
  if [ -f "$BIN_DIR/$name" ]; then
    info "$name already installed, skipping..."
    return
  fi
  info "Installing $name..."
  local tmp
  tmp=$(mktemp -d)
  curl -fsSL "$url" | tar -xz -C "$tmp"
  mv "$tmp/$binary_in_archive" "$BIN_DIR/$name"
  chmod +x "$BIN_DIR/$name"
  rm -rf "$tmp"
}

# ---------------------------------------------------------------------------
# apt packages
# ---------------------------------------------------------------------------

APT_PACKAGES=(
  awscli
  bat
  curl
  direnv
  fd-find
  fzf
  git
  htop
  ispell
  jq
  mysql-client
  nmap
  pre-commit
  procps
  ripgrep
  silversearcher-ag
  stow
  telnet
  tmux
  tree
  wget
)

install_apt_packages() {
  info "Updating apt..."
  sudo apt-get update -q

  info "Installing apt packages..."
  sudo apt-get install -y -q "${APT_PACKAGES[@]}"

  # bat is installed as batcat on Ubuntu — symlink to bat
  if command -v batcat &>/dev/null && [ ! -e "$BIN_DIR/bat" ]; then
    ln -s "$(command -v batcat)" "$BIN_DIR/bat"
  fi

  # fd-find is installed as fdfind on Ubuntu — symlink to fd
  if command -v fdfind &>/dev/null && [ ! -e "$BIN_DIR/fd" ]; then
    ln -s "$(command -v fdfind)" "$BIN_DIR/fd"
  fi
}

# ---------------------------------------------------------------------------
# GitHub CLI (official apt repo)
# ---------------------------------------------------------------------------

install_gh() {
  if command -v gh &>/dev/null; then
    info "gh already installed, skipping..."
    return
  fi
  info "Installing GitHub CLI..."
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=${ARCH} signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
  sudo apt-get update -q && sudo apt-get install -y gh
}

# ---------------------------------------------------------------------------
# kubectl (official apt repo)
# ---------------------------------------------------------------------------

install_kubectl() {
  if command -v kubectl &>/dev/null; then
    info "kubectl already installed, skipping..."
    return
  fi
  info "Installing kubectl..."
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key \
    | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /" \
    | sudo tee /etc/apt/sources.list.d/kubernetes.list >/dev/null
  sudo apt-get update -q && sudo apt-get install -y kubectl
}

# ---------------------------------------------------------------------------
# Terraform (official HashiCorp apt repo)
# ---------------------------------------------------------------------------

install_terraform() {
  if command -v terraform &>/dev/null; then
    info "terraform already installed, skipping..."
    return
  fi
  info "Installing terraform..."
  wget -qO- https://apt.releases.hashicorp.com/gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null
  sudo apt-get update -q && sudo apt-get install -y terraform
}

# ---------------------------------------------------------------------------
# Helm (official install script)
# ---------------------------------------------------------------------------

install_helm() {
  if command -v helm &>/dev/null; then
    info "helm already installed, skipping..."
    return
  fi
  info "Installing helm..."
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
}

# ---------------------------------------------------------------------------
# Atuin (official install script)
# ---------------------------------------------------------------------------

install_atuin() {
  if command -v atuin &>/dev/null; then
    info "atuin already installed, skipping..."
    return
  fi
  info "Installing atuin..."
  curl -fsSL https://setup.atuin.sh | bash
}

# ---------------------------------------------------------------------------
# Zoxide (official install script)
# ---------------------------------------------------------------------------

install_zoxide() {
  if command -v zoxide &>/dev/null; then
    info "zoxide already installed, skipping..."
    return
  fi
  info "Installing zoxide..."
  curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
}

# ---------------------------------------------------------------------------
# Pinned GitHub release binaries
# To upgrade a tool, bump its version variable below.
# ---------------------------------------------------------------------------

install_k9s() {
  local version="v0.32.5"
  install_gh_tarball "k9s" \
    "https://github.com/derailed/k9s/releases/download/${version}/k9s_Linux_${ARCH}.tar.gz" \
    "k9s"
}

install_doctl() {
  local version="1.110.0"
  install_gh_tarball "doctl" \
    "https://github.com/digitalocean/doctl/releases/download/v${version}/doctl-${version}-linux-${ARCH}.tar.gz" \
    "doctl"
}

install_hurl() {
  local version="4.3.0"
  local arch_name="x86_64"
  [ "$ARCH" = "arm64" ] && arch_name="aarch64"
  local archive="hurl-${version}-${arch_name}-unknown-linux-gnu"
  install_gh_tarball "hurl" \
    "https://github.com/Orange-OpenSource/hurl/releases/download/${version}/${archive}.tar.gz" \
    "${archive}/bin/hurl"
}

install_ov() {
  local version="v0.36.2"
  install_gh_tarball "ov" \
    "https://github.com/noborus/ov/releases/download/${version}/ov_Linux_${ARCH}.tar.gz" \
    "ov"
}

install_argocd() {
  local version="v2.12.0"
  install_gh_binary "argocd" \
    "https://github.com/argoproj/argo-cd/releases/download/${version}/argocd-linux-${ARCH}"
}

install_lefthook() {
  local version="1.6.12"
  install_gh_tarball "lefthook" \
    "https://github.com/evilmartians/lefthook/releases/download/v${version}/lefthook_${version}_Linux_${ARCH}.tar.gz" \
    "lefthook"
}

install_yamlfmt() {
  local version="v0.13.0"
  install_gh_tarball "yamlfmt" \
    "https://github.com/google/yamlfmt/releases/download/${version}/yamlfmt_${version#v}_Linux_${ARCH}.tar.gz" \
    "yamlfmt"
}

install_editorconfig_checker() {
  local version="v3.0.3"
  local binary="ec-linux-${ARCH}"
  install_gh_tarball "editorconfig-checker" \
    "https://github.com/editorconfig-checker/editorconfig-checker/releases/download/${version}/ec-linux-${ARCH}.tar.gz" \
    "bin/${binary}"
}

install_tealdeer() {
  local version="v1.6.1"
  local arch_name="x86_64"
  [ "$ARCH" = "arm64" ] && arch_name="aarch64"
  install_gh_binary "tldr" \
    "https://github.com/dbrgn/tealdeer/releases/download/${version}/tealdeer-linux-${arch_name}-musl"
}

install_fx() {
  local version="35.0.0"
  local arch_name="amd64"
  [ "$ARCH" = "arm64" ] && arch_name="arm64"
  install_gh_binary "fx" \
    "https://github.com/antonmedv/fx/releases/download/${version}/fx_linux_${arch_name}"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

install_apt_packages
install_gh
install_kubectl
install_terraform
install_helm
install_atuin
install_zoxide
install_k9s
install_doctl
install_hurl
install_ov
install_argocd
install_lefthook
install_yamlfmt
install_editorconfig_checker
install_tealdeer
install_fx

warn "pure prompt: not auto-installed on Linux."
warn "  Install via: npm install --global pure-prompt"

info "Linux packages installed. Ensure $BIN_DIR is in your PATH."

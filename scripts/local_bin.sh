#!/usr/bin/env bash
set -e

# Bootstrap
source "$(dirname "$0")/../_bootstrap.sh"

if [ ! -d "/usr/local/go" ]; then 
  VERSION=1.24.3
  OS=$(uname -s | tr '[:upper:]' '[:lower:]')-amd64
  curl -L https://go.dev/dl/go${VERSION}.${OS}.tar.gz | sudo tar -xzC /usr/local

MARKER='gopath'
BLOCK=$(cat <<'EOF'
export PATH="$PATH:/usr/local/go/bin"
EOF
)
  add_once_to_file "$MARKER" "$BLOCK" ~/.zshrc
fi

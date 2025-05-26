#!/usr/bin/env bash
set -ex

# Bootstrap
source "$(dirname "$0")/../_bootstrap.sh"

VERSION=v0.16.4
LOCATION=/usr/local/bin
EXECUTABLE=asdf

asdf_install() {
  # Version v0.17.0 Binary is not working, building from source for now
  curl -L "https://github.com/asdf-vm/asdf/releases/download/${VERSION}/asdf-${VERSION}-linux-amd64.tar.gz" \
    | sudo tar -xzC $LOCATION asdf

  asdf plugin add nodejs || true
  # asdf plugin add golang || true
  asdf plugin add python || true
  asdf plugin add terraform || true
  asdf plugin add kubectl || true
  asdf plugin add awscli || true
  asdf plugin add kustomize || true
  asdf plugin add task || true
  asdf plugin add helm || true
  asdf plugin add terragrunt https://github.com/ohmer/asdf-terragrunt || true
}

# Enable shims in current bash, in zsh done via plugins
MARKER='.asdf/shims'
BLOCK=$(cat <<'EOF'
if [ -d "$HOME/.asdf/shims" ] ; then
  export PATH="$HOME/.asdf/shims:$PATH"
fi
EOF
)
add_once_to_file "$MARKER" "$BLOCK"
add_once_to_file "$MARKER" "$BLOCK" ~/.zshrc

if [ ! -f "$LOCATION/$EXECUTABLE" ]; then
  asdf_install
else
  actual_version="$("$LOCATION/$EXECUTABLE" --version 2>/dev/null | head -n1 | awk '{print $NF}')"
  if [ "$actual_version" != "$VERSION" ]; then
    asdf_install
  else
    echo "Nothing to do"
  fi
fi

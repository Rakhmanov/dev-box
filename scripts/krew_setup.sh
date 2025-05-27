#!/usr/bin/env bash
set -e

# Bootstrap
source "$(dirname "$0")/../_bootstrap.sh"

if [ ! -d $HOME/.krew ]; then
  # Install krew
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )
fi

MARKER='KREW_ROOT'
BLOCK=$(cat <<'EOF'
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
EOF
)
add_once_to_file "$MARKER" "$BLOCK" # Add to path file
add_once_to_file "$MARKER" "$BLOCK" ~/.zshrc # Add to future zschrc context

# Refresh to get KREW binary
source ~/.path_additions

kubectl krew install ns
kubectl krew install ctx
kubectl krew install node-shell

# Kubectx kubens autocomplete
git clone --depth 1 https://github.com/ahmetb/kubectx /tmp/kubectx
mkdir -p ~/.oh-my-zsh/custom/completions
mv /tmp/kubectx/completion/_kubectx.zsh ~/.oh-my-zsh/custom/completions/_kubectx.zsh || true
mv /tmp/kubectx/completion/_kubens.zsh ~/.oh-my-zsh/custom/completions/_kubens.zsh || true
rm -rf /tmp/kubectx

# Add custom completions to the Path
MARKER='$ZSH/custom/completions'
BLOCK=$(cat <<'EOF'
fpath=($ZSH/custom/completions $fpath)
EOF
)
add_once_to_file "$MARKER" "$BLOCK" ~/.zshrc # Add to future zschrc context


#!/usr/bin/env bash
set -e
GIT_NAME="$1"
GIT_EMAIL="$2"

sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget unzip build-essential \
  zsh fzf ripgrep fd-find \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
  libsqlite3-dev llvm libncurses5-dev libncursesw5-dev \
  xz-utils tk-dev libffi-dev liblzma-dev

# Configure git if params are provided
if [[ -n "$GIT_NAME" && -n "$GIT_EMAIL" ]]; then
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
fi

# Install VSCode (WSL already integrates)
code --install-extension ms-azuretools.vscode-docker
code --install-extension golang.go
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension hashicorp.terraform
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension amazonwebservices.aws-toolkit-vscode
code --install-extension redhat.vscode-yaml

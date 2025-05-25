#!/usr/bin/env bash
set -e

if [ ! -d "$HOME/.asdf" ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
fi

. "$HOME/.asdf/asdf.sh"

asdf plugin add nodejs || true
asdf plugin add golang || true
asdf plugin add python || true
asdf plugin add terraform || true
asdf plugin add kubectl || true
asdf plugin add awscli || true

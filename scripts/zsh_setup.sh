#!/usr/bin/env bash
set -x

# Bootstrap
source "$(dirname "$0")/../_bootstrap.sh"

# Detect WSL
if grep -qi microsoft /proc/version; then
  IS_WSL=true
else
  IS_WSL=false
fi

# Add aliases
if [ ! -f ~/.zsh_aliases ] || ! grep -qF "$(head -n 1 ./scripts/static/.zsh_aliases)" ~/.zsh_aliases; then
  cat ./scripts/static/.zsh_aliases >> ~/.zsh_aliases
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set zsh as default shell
if [ "$IS_WSL" = true ]; then
  # In WSL: add exec zsh to .bashrc
  if ! grep -q "exec zsh" ~/.bashrc; then
    echo 'exec zsh' >> ~/.bashrc
  fi
else
  # Not in WSL: safe to run chsh
  if [ "$(basename "$SHELL")" != "zsh" ]; then
    chsh -s "$(which zsh)"
  fi
fi

# Add plugins (e.g., autosuggestions, syntax highlighting)
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-autosuggestions ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions || true
fi
if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting || true 
fi

# Install powerlevel10k theme
if [ ! -d ${ZSH_CUSTOM}/themes/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
  echo "source ${ZSH_CUSTOM}/themes/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
fi

sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

PLUGINS_BLOCK='plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  argocd
  asdf
  aws
  docker
  dotenv
  fzf
  git
  gh
  golang
  helm
  kubectl
  kubectx
  pip
  pyenv
  python
  terraform
)'

# Remove existing plugins=(...) block (even with comments/spacing)
sed -i '/^plugins=(/{:a;N;/)/!ba;d}' ~/.zshrc

# Append the new plugins block
echo "$PLUGINS_BLOCK" >> ~/.zshrc

MARK='autoload'
BLOCK='autoload -Uz compinit && compinit'
add_once_to_file "$MARK" "$BLOCK" ~/.zshrc

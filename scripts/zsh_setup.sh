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

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Set zsh as default shell
# This will work, also can be set in 
if [ "$IS_WSL" = true ]; then
  # In WSL: add exec zsh to .bashrc
  if [ "$USER" != "root" ] && [ "$(getent passwd "$USER" | cut -d: -f7)" != "/usr/bin/zsh" ]; then
    sudo usermod -s /usr/bin/zsh "$USER"
  fi
else
  # Not in WSL: safe to run chsh
  if [ "$(basename "$SHELL")" != "zsh" ]; then
    chsh -s "$(which zsh)"
  fi
fi

# Add aliases
if ! grep -qF "$(head -n 1 ./scripts/static/.zsh_aliases)" ~/.zsh_aliases 2>/dev/null; then
  # Create aliases file
  add_once_to_file "custom zsh aliases" "$(cat ./scripts/static/.zsh_aliases)" "$HOME/.zsh_aliases"

  # Load in zshrc
  add_once_to_file '.zsh_aliases' 'source ~/.zsh_aliases' ~/.zshrc
fi

# Add zprofile file with entry to source zshrc on load
add_once_to_file '.zprofile' '[[ -f ~/.zshrc ]] && source ~/.zshrc' ~/.zprofile

# Add autosuggestions plugin
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-autosuggestions ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions || true
fi

# Add highlights plugin
if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting || true 
fi

# Add powerlevel10k theme
if [ ! -d ${ZSH_CUSTOM}/themes/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
  echo "source ${ZSH_CUSTOM}/themes/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
fi

# Download Fonts
mkdir -p ~/.local/share/fonts
wget -O /tmp/Meslo.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
unzip -o /tmp/Meslo.zip -d ~/.local/share/fonts
rm /tmp/Meslo.zip
fc-cache -fv

# Set theme to powerlevel10k/powerlevel10k
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

# Autoload the completion in zsh
add_once_to_file 'autoload' 'autoload -Uz compinit && compinit' ~/.zshrc

# Uncomment zsh line for bins
sed -i '/^# export PATH=\$HOME\/bin:/s/^# //' ~/.zshrc

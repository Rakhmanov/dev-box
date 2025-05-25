#!/usr/bin/env bash
set -e

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Set zsh as default
chsh -s $(which zsh)

# Add plugins (e.g., autosuggestions, syntax highlighting)
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting || true

# Add plugins and aliases in .zshrc
grep -q "zsh-autosuggestions" ~/.zshrc || sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

cat <<EOF >> ~/.zshrc

# Custom aliases
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
EOF

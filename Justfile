set shell := ["bash", "-cu"]

default:
    just bootstrap

bootstrap name="" email="":
    just apt_inits
    ./scripts/install_go.sh
    just set_git_config "{{name}}" "{{email}}"
    ./scripts/local_bin.sh
    ./scripts/zsh_setup.sh
    ./scripts/asdf_setup.sh
    just install_tools
    ./scripts/krew_setup.sh
    echo "Completed"

apt_inits:
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y git curl wget unzip build-essential \
    zsh fonts-powerline fontawesome fzf yq jq ripgrep fd-find \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
    libsqlite3-dev llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev 

set_git_config name email:
    git config --global user.name "{{name}}"
    git config --global user.email "{{email}}"

install_tools:
    just install_and_set nodejs latest
    # just install_and_set golang latest
    just install_and_set python latest
    just install_and_set terraform latest
    just install_and_set kubectl latest
    just install_and_set awscli latest
    just install_and_set terragrunt latest

# Use after connecting to the WSL via VS Code
vscode_extensions:
    ./install_vscode_extensions.sh

# Internal functions
@install_and_set app version:
    asdf install {{app}} {{version}}
    asdf set --home {{app}} {{version}}
default:
    just bootstrap

bootstrap name="" email="":
    ./provision.sh "{{name}}" "{{email}}"
    ./zsh_setup.sh
    ./asdf_setup.sh
    just install_tools

install_tools:
    asdf install nodejs latest
    asdf global nodejs latest
    asdf install golang latest
    asdf global golang latest
    asdf install python latest
    asdf global python latest
    asdf install terraform latest
    asdf install kubectl latest
    asdf install awscli latest


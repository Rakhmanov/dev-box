# Install VSCode (WSL already integrates)
if [ -n "$VSCODE_IPC_HOOK_CLI" ]; then
    code --install-extension ms-azuretools.vscode-docker
    code --install-extension golang.go
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension hashicorp.terraform
    code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
    code --install-extension amazonwebservices.aws-toolkit-vscode
    code --install-extension redhat.vscode-yaml
else
  echo "Skipping VS Code extension install: not in VS Code Remote session."
fi

# 🛠️ Ubuntu 24.04+ Dev Environment Setup (Tested on WSL2)

This scaffolds a clean developer environment using `just` and provides steps to create a new WSL profile based on Ubuntu 24.04.

---

Includes:

    - zsh
        - build-essential, yq, jq, git, fzf, curl, wget, unzip
    - oh-my-zsh
    - golang
    - asdf (items below installed by asdf:)
    - kubectl
        - krew
        - kubectl-ns
        - kubectl-ctx
        - node-shell
    - helm
    - kustomize
    - terraform
    - terragrunt
    - python
    - nodejs
    - awscli
    - task


## 📦 Prerequisites

### Install `just` task runner

```bash
sudo apt install --update just
```

---

## 🚀 Usage

### Checkout
```bash
git clone --depth=1 https://github.com/Rakhmanov/dev-box.git
cd dev-box
```

### Bootstrap your dev environment
just bootstrap "Full Name" "email@example.com"
Running bootstrap requires providing 2 parameter, which will be used to configure git.

1) Full Name
2) E-mail

```bash
just bootstrap "Denis Shatilov" "shatilov18@gmail.com"
```

### Install tools only

```bash
just install_tools
```

---

## Set Up WSL

### 1. Download the Ubuntu 24.04 Image

```bash
wget https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64-root.tar.xz -O ubuntu-24.04.tar.xz
```

### 2. Export an Existing Image (Optional)
Keep in mind the format is tar and it's not compressed.

```powershell
wsl --export Ubuntu-24.04 existing-ubuntu-24.04.tar
```

### 3. Import the Image

```powershell
wsl --import dev-box C:\WSL\dev-box ubuntu-24.04.tar.xz
```

### 4. Load image
```powershell
wsl -d dev-box
```

### 5. Create a User (inside the WSL instance)

```bash
USERNAME=admin
useradd -m -s /bin/bash -g admin $USERNAME
echo "$USERNAME:password" | chpasswd
usermod -aG sudo $USERNAME
echo -e "[user]\ndefault=admin" | tee /etc/wsl.conf
```

### 6. Shutdown so /etc/wsl.conf changes woule be re-read.
```powershell
wsl.exe --shutdown
```

### 7. Turn on the WSL distribution
```powershell
wsl -d dev-box
```

### 8. (Optional) Set Default Distro via PowerShell

```powershell
wsl --set-default dev-box
```

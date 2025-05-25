Here's a cleaned-up and professional version of your README:

---

# 🛠️ Dev Environment Setup – Ubuntu 24.04+ (Tested on WSL2)

This scaffolds a clean developer environment using `just` and provides steps to create a new WSL profile based on Ubuntu 24.04.

---

## 📦 Prerequisites

### Install `just` task runner

```bash
sudo apt install just
```

---

## 🚀 Usage

### Bootstrap your dev environment

```bash
just bootstrap --name "Denis Shatilov" --email "shatilov18@gmail.com"
```

### Install tools only

```bash
just install_tools
```

---

## 🐧 Create a New WSL Profile (Ubuntu 24.04)

### 1. Download the Ubuntu 24.04 Image

```bash
wget https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64-root.tar.xz -O ubuntu-24.04.tar.xz
```

### 2. Export an Existing Image (Optional)

```powershell
wsl --export Ubuntu-24.04 ubuntu-24.04-empty.tar
```

### 3. Import the Image

```powershell
wsl --import dev-box C:\WSL\dev-box ubuntu-24.04-empty.tar
```

---

## 👤 Set Up User in WSL

### 4. Create a User (inside the WSL instance)

```bash
adduser admin
usermod -aG sudo admin
```

### 5. Set Default User

```bash
echo -e "[user]\ndefault=admin" | sudo tee /etc/wsl.conf
```

### 6. (Optional) Set Default Distro via PowerShell

```powershell
wsl --set-default dev-box
```

---

Let me know if you want to include Dotfiles, Docker, or package managers like `asdf` or `brew` in the bootstrap.

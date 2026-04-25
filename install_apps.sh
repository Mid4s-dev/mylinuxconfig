#!/bin/bash

# Exit on error
set -e

echo "Starting restoration of Linux desktop apps..."

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# Install common dependencies
sudo apt install -y curl wget gpg apt-transport-https ca-certificates software-properties-common

# 1. Add Third-Party Repositories
echo "Adding external repositories..."

# VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

# Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

# 2. Update and Install Apps
sudo apt update

echo "Installing core applications..."
sudo apt install -y \
    code \
    brave-browser \
    google-chrome-stable \
    docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
    vim htop curl wget git build-essential \
    gimp vlc flameshot qbittorrent redshift redshift-gtk \
    virt-manager virtualbox \
    adb composer nodejs npm \
    gnome-boxes baobab deja-dup \
    mate-terminal pluma \
    transmission-gtk

# 3. Third party installers (Manual or script-based)
echo "Setting up JetBrains Tools (WebStorm, PyCharm, IDEA) - Tip: Use Toolbox for these"
# (Usually these are handled via JetBrains Toolbox or manual download)

echo "Setting up Android Studio - Tip: Use Toolbox or manual download"

echo "Installation complete!"
echo "Note: Some apps like Postman, DBeaver, or LocalWP might need manual download or Snap installation."

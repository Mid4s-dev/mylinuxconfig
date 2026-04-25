#!/bin/bash
echo "Applying configurations..."
cp configs/bashrc ~/.bashrc
cp configs/gitconfig ~/.gitconfig
if [ -f configs/vscode-settings.json ]; then
    mkdir -p ~/.config/Code/User/
    cp configs/vscode-settings.json ~/.config/Code/User/settings.json
fi
echo "Configs applied. Please restart your terminal."

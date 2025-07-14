#!/bin/bash

set -e

echo "🚀 Starting fresh setup using Suhas's dotfiles..."

# === SYSTEM CHECK ===
echo "🔍 Checking for required packages..."

# Update and install basic tools
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git neovim zsh unzip wget python-pip cronie

# Optional: install lazygit, kitty, lf, etc. if part of your workflow
# sudo pacman -S --noconfirm lazygit kitty lf

# === CLONE DOTFILES ===
echo "📁 Cloning dotfiles repo..."
git clone https://github.com/suhasofficial/dotfiles.git ~/dotfiles || echo "📁 dotfiles already cloned"
cd ~/dotfiles

# === RESTORE NEOVIM ===
echo "🧠 Setting up Neovim config..."
mkdir -p ~/.config
cp -r .config/nvim ~/.config/

# === INSTALL NEOVIM PLUGIN MANAGER (e.g., lazy.nvim) ===
echo "📦 Installing lazy.nvim plugin manager..."
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/site/pack/lazy/start/lazy.nvim || echo "✅ lazy.nvim already installed"

# === INSTALL KONSAVE ===
echo "🎨 Installing Konsave for KDE configs..."
pip install --user konsave
export PATH="$HOME/.local/bin:$PATH"

# === APPLY KDE PROFILE (if .knsv file exists) ===
if [ -f "mysetup.knsv" ]; then
    echo "🎛️ Applying KDE Konsave profile..."
    konsave -i mysetup.knsv
    konsave -a mysetup
else
    echo "⚠️  No konsave profile found. Skipping KDE restore."
fi

# === RESTORE OTHER CONFIG FILES ===
echo "🛠️ Restoring shell, git, and other config files..."
cp -f ~/.dotfiles/.zshrc ~ 2>/dev/null || true
cp -f ~/.dotfiles/.bashrc ~ 2>/dev/null || true
cp -f ~/.dotfiles/.gitconfig ~ 2>/dev/null || true

# === RESTORE KROHNKITE ===
echo "🪟 Restoring Krohnkite KWin script..."
mkdir -p ~/.local/share/kwin/scripts/
cp -r .local/share/kwin/scripts/krohnkite ~/.local/share/kwin/scripts/ || echo "⚠️  Krohnkite not found in dotfiles."

# === START CRONIE (for auto-backups, if used) ===
echo "⏰ Enabling cron for auto-backups..."
sudo systemctl enable cronie
sudo systemctl start cronie

# === DONE ===
echo "✅ Setup complete! You may now reboot for full KDE settings to apply."


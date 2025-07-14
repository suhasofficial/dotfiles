#!/bin/bash

set -e  # Stop script on error

echo "🔄 Backing up config files to ~/dotfiles..."

# === FOLDER SETUP ===
mkdir -p ~/dotfiles/.config
mkdir -p ~/dotfiles/.local/share/kwin/scripts

# === NEOVIM ===
echo "📦 Backing up Neovim..."
cp -r ~/.config/nvim ~/dotfiles/.config/

# === KDE CONFIGS ===
echo "🎨 Backing up KDE configs..."
cp -f ~/.config/kdeglobals ~/dotfiles/.config/ 2>/dev/null || echo "⏭️  kdeglobals not found"
cp -f ~/.config/kwinrc ~/dotfiles/.config/ 2>/dev/null || echo "⏭️  kwinrc not found"
cp -f ~/.config/kglobalshortcutsrc ~/dotfiles/.config/ 2>/dev/null || echo "⏭️  shortcuts not found"
cp -f ~/.config/plasmashellrc ~/dotfiles/.config/ 2>/dev/null || echo "⏭️  plasmashellrc not found"
cp -f ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/dotfiles/.config/ 2>/dev/null || echo "⏭️  appletsrc not found"
cp -f ~/.config/krunnerrc ~/dotfiles/.config/ 2>/dev/null || echo "⏭️  krunnerrc not found"

# === KROHNKITE SCRIPT ===
echo "🪟 Backing up Krohnkite..."
cp -r ~/.local/share/kwin/scripts/krohnkite ~/dotfiles/.local/share/kwin/scripts/ 2>/dev/null || echo "⏭️  Krohnkite not found"

# === SHELL & CLI CONFIGS ===
echo "🖥️ Backing up shell and Git configs..."
cp -f ~/.zshrc ~/dotfiles/ 2>/dev/null || echo "⏭️  .zshrc not found"
cp -f ~/.bashrc ~/dotfiles/ 2>/dev/null || echo "⏭️  .bashrc not found"
cp -f ~/.gitconfig ~/dotfiles/ 2>/dev/null || echo "⏭️  .gitconfig not found"

# === GIT COMMIT ===
cd ~/dotfiles
git add .
git commit -m "📦 Backup: Auto-synced config files on $(date '+%Y-%m-%d %H:%M')"
git push

echo "✅ Backup complete and pushed to GitHub!"


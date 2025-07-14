# 🔧 Suhas's Dotfiles

Welcome to my personal dotfiles repo!  
This repository contains the config files for my development environment and KDE Plasma setup — fully portable and minimal.

---

## 📦 What's Included

- 🧠 **Neovim** config with plugin manager (`lazy.nvim`)
- 🎨 **KDE Plasma** layout, global shortcuts, panel setup (via `konsave`)
- 🪟 **Krohnkite** KWin tiling script
- 🖥️ Shell configs (`.zshrc`, `.bashrc`)
- 🔁 Auto-backup script with Git
- 🛠️ `setup.sh` for installing everything on a new system

---

## 🚀 Setup on a New Machine

1. **Install Git:**

   ```bash
   sudo pacman -S git

    Clone this repo:

git clone https://github.com/suhasofficial/dotfiles.git ~/dotfiles
cd ~/dotfiles

Run the setup script:

    bash setup.sh

✅ This will:

    Copy all config files into your system

    Restore Neovim + plugins

    Restore KDE Plasma layout (if mysetup.knsv is available)

    Reinstall Krohnkite tiling manager

    Enable cron (for scheduled backups)

♻️ Backing Up Your Configs

After making changes to your setup, run:

bash ~/dotfiles/backup.sh

This will:

    Copy your latest system config back into the dotfiles repo

    Commit and push changes to GitHub

🗂️ Folder Structure

dotfiles/
├── .config/
│   ├── nvim/
│   ├── kwinrc
│   ├── kdeglobals
│   └── ...
├── .local/share/kwin/scripts/krohnkite/
├── .zshrc
├── .bashrc
├── .gitconfig
├── mysetup.knsv        # (Optional) Konsave KDE profile
├── backup.sh
└── setup.sh

🔧 Tools Used

    Neovim

    Lazy.nvim

    Konsave

    Krohnkite

🧠 Notes

    You can modify backup.sh or setup.sh to fit your evolving setup.

    Remember to run konsave -e mysetup before exporting an updated KDE profile.

    This repo is best used with KDE Plasma on Arch/EndeavourOS-based distros.

📬 Author

Suhas KM
📸 Instagram: @suhasofficialy
💻 GitHub: @suhasofficial

✨ Star this repo if it helped you. Contributions welcome!


---

Let me know if you want a version with:
- screenshots of your KDE setup
- setup video/GIF badges
- license section (MIT, etc.)

Want me to auto-add this to your repo now?

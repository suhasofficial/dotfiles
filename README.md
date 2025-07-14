🔧 Suhas's Dotfiles





Welcome to my personal dotfiles repo!This repository contains the config files for my development environment and KDE Plasma setup — fully portable and minimal.

📦 What's Included

🧠 Neovim config with plugin manager (lazy.nvim)

🎨 KDE Plasma layout, global shortcuts, and panels via konsave

🪿 Krohnkite KWin tiling script

💥 Shell configs: .zshrc, .bashrc

🔁 Auto-backup script using Git

🛠️ setup.sh to install everything on a new machine

🚀 Setup on a New Machine

Install Git

sudo pacman -S git

Clone the repo

git clone https://github.com/suhasofficial/dotfiles.git ~/dotfiles
cd ~/dotfiles

Run the setup script

bash setup.sh

✅ This will:

Copy all config files into your system

Restore Neovim and plugins

Restore KDE Plasma layout (if mysetup.knsv exists)

Install Krohnkite tiling manager

Enable cron for automatic backups

♻️ Backup Your Configs

To backup changes to your dotfiles, run:

bash ~/dotfiles/backup.sh

This will:

Copy updated configs back to the dotfiles folder

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
├── mysetup.knsv         # (optional konsave profile)
├── backup.sh
└── setup.sh

🔧 Tools Used

Neovim + Lazy.nvim

Konsave (KDE layout manager)

Krohnkite (KWin tiling extension)

🧠 Notes

Modify setup.sh or backup.sh to suit your workflow

Run konsave -e mysetup to export updated KDE layout

Best used on Arch Linux or EndeavourOS with KDE Plasma

🖼️ Screenshot

(Optional: Add a screenshot of your desktop below)



📬 Author

Suhas KM📸 Instagram: @suhasofficiall💻 GitHub: @suhasofficial



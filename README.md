# My KDE Dotfiles

Welcome to my personal dotfiles repo! This repository contains the config files for my development environment and KDE Plasma setup — fully portable and minimal.

---

## What's Included

* 🧠 Neovim config with plugin manager (lazy.nvim)
* 🎨 KDE Plasma layout, global shortcuts, and panels via konsave
* 🪿 Krohnkite KWin tiling script
* 💥 Shell configs: .zshrc, .bashrc
* 🔁 Auto-backup script using Git
* 🛠️ setup.sh to install everything on a new machine

---

## Setup on a New Machine

1.  Install Git

    ```bash
    sudo pacman -S git
    ```

2.  Clone the repo

    ```bash
    git clone [https://github.com/suhasofficial/dotfiles.git](https://github.com/suhasofficial/dotfiles.git) ~/dotfiles
    cd ~/dotfiles
    ```

3.  Run the setup script

    ```bash
    bash setup.sh
    ```

This will:
* Copy all config files into your system
* Restore Neovim and plugins
* Restore KDE Plasma layout (if mysetup.knsv exists)
* Install Krohnkite tiling manager
* Enable cron for automatic backups

---

## Backup Your Configs

To backup changes to your dotfiles, run:

```bash
bash ~/dotfiles/backup.sh

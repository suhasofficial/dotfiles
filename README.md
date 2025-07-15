<p align="center"><a name="top" href="#"><img src="https://github.com/suhasofficial/dotfiles/blob/main/previews/header.png?raw=true"></a></p>

<h2 align="center"> Preview </h2>

<h3 align="center"> Purple Crosswalk </h3>

![](https://github.com/suhasofficial/dotfiles/blob/main/previews/1.png?raw=true)

![](https://github.com/suhasofficial/dotfiles/blob/main/previews/2.png?raw=true)

![](https://github.com/suhasofficial/dotfiles/blob/main/previews/3.png?raw=true)

![](https://github.com/suhasofficial/dotfiles/blob/main/previews/4.png?raw=true)


## :sparkles: Thanks for visiting! 

-  **OS:** Endeavour os
-  **DE:** Plasma 6.4
-  **WM:** Kröhnkite
-  **Terminal:** Kitty
-  **Shell:** zsh + Oh My Zsh + Powerlevel10k
-  **Terminal Font:** SFMono Nerd Font, JetBrainsMono NF
-  **System Font:** SF Pro Text
-  **Bar/Panel:** default KDE panel
-  **File Manager:** Dolphin
-  **Editor:** VS Code, Neovim
-  **Browser:** Firefox
-  **Music Player:** Spotify 

Firefox CSS sources: i will uplaod soon
 
## 📦 Dependencies

- wpgtk
- git
- polybar
- powerlevel10k
- spicetify

## :paperclip: Recommendations

-  i have included my VS code extension list

## :hammer_and_wrench: Setup

**(work in progress)**

Set your Global Theme to Breeze Dark before you proceed.

**Install the dependencies:**

- ```bash
  # Use your helper of choice
  yay -S latte-dock-git wpgtk-git 
  ```
<details open>
<summary><strong>Clone and copy most of the stuff</strong></summary>
  
- ```bash
  git clone https://github.com/ComplexPlatform/KDE-dotfiles
    ```
- ```bash
  # Copy .local, .config, .themes, and .ncmpcpp to your home directory.
  cd KDE-dotfiles/ && cp -r {.local,.config,.themes,.ncmpcpp} ~/
  ```
   
</details>

To remove title bars and add active/inactive frame colors, follow [this guide](https://github.com/esjeon/krohnkite#removing-title-bars)

To change your Latte layout, right click on your dock/panel > Layouts > pick your layout of choice.

<details open>
  <summary><strong>Extract Icons</strong></summary>
  
- ```bash
  cd ~/.local/share/icons/
  ls *.xz |xargs -n1 tar -xf

  # Delete leftover archives
  rm *.tar.xz
  ```
     
</details>

<details open>
  <summary><strong>wpgtk</strong></summary>

1. Add wallpapers and import color schemes:

- ```bash
  # Assuming you're in KDE-Dotfiles directory
  # Add wallpapers
  wpg -a walls/foggy-mountain_01.jpg
  wpg -a walls/coffee.jpg
  wpg -a walls/flowers.jpg
  wpg -a walls/urban.jpg
  wpg -a walls/cherryblossom.jpg
  wpg -a walls/neutral.jpg
  ```
- ```bash
  # Assuming you're in KDE-Dotfiles directory
  # Import color schemes
  wpg -i foggy-mountain_01.jpg colorschemes/foggy-mountain.json
  wpg -i coffee.jpg colorschemes/coffee.json
  wpg -i flowers.jpg colorschemes/flowers.json
  wpg -i urban.jpg colorschemes/urban.json
  wpg -i cherryblossom.jpg colorschemes/cherryblossom.json
  wpg -i neutral.jpg colorschemes/neutral.json
  ```

2. Add templates:

- ```bash
  # Backups are automatically made just in case something goes wrong.
  wpg -ta ~/.config/kdeglobals
  wpg -ta ~/.local/share/konsole/wpgtk.colorscheme
  wpg -ta ~/.local/share/plasma/desktoptheme/CullaX/colors
  ```

3. Add variables/keywords to the templates:

- ```bash
  # Identify the templates` filenames first on ~/.config/wpg/templates
  # Replace <filename>.base with yours
  # Assuming you're in KDE-dotfiles directory
  cd wpgtktemplates
  cat kdeglobals.base > ~/.config/wpg/templates/<your_kdeglobals>.base
  cat colors.base > ~/.config/wpg/templates/<your_cullax_colors>.base
  cat konsole.base > ~/.config/wpg/templates/<your_konsole>.base
  ```

4. Set the color scheme:

- ```bash
  wpg -s <scheme>.jpg
  # Replace <scheme> with your color scheme of choice.
  # For example
  wpg -s Flowers.jpg
  ```

Unfortunately, you have to set your wallpaper manually.
</details>

If you're using `Spicetify` with `Dribbblish`, run the following:

```bash
xrdb -merge ~/.cache/wal/colors.Xresources
spicetify config color_scheme pywal
spicetify apply
```

<details open>
<summary><strong>Set Plasma theme</strong></summary>
  
 - System Settings > Plasma Style, set it to CullaX.
 - System Settings > Application Style, set it to gtk2. Click `Configure GNOME/GTK Application Style...`, set the GTK2 and GTK3 theme your theme of choice.
- System Settings > Icons, set the icon theme to your theme of choice.

To remove the titlebar buttons:
- System Settings > Application Style > Window Decorations > Titlebar Buttons, drag the buttons and drop them down to the list.

To change the titlebar size:
- System Settings > Application Style > Window Decorations, click the edit icon on `Breeze`. Change button size to whatever you want.

</details>

## :ice_cream: Optional Stuff

<details open>
<summary><strong>dunst</strong></summary>
  
You can use [`dunst`](https://github.com/dunst-project/dunst) instead by renaming KDE's notification service so it gets ignored.

```bash
# Make sure dunst is installed beforehand
cd /usr/share/dbus-1/services
sudo mv org.kde.plasma.Notifications.service org.kde.plasma.Notifications.service-disabled
```
Log out and log back in again to see the changes.

</details>


# .arch

> Dotfiles for Archlinux.

## Showcase

<details>
<summary>Music Playing</summary>

![music](https://github.com/huge-pancake/.arch/assets/73375859/b1a6301a-8695-488d-828b-3af68acb5005)

</details>

<details>
<summary>NeoVim</summary>

![neovim-startup-screen](https://github.com/huge-pancake/.arch/assets/73375859/05f999e1-c91a-4c5c-9563-cc9e2fa0c77b)
![neovim-package-manager](https://github.com/huge-pancake/.arch/assets/73375859/983e73b5-ca65-4b3b-96e4-956da21adc2b)
![neovim-editing](https://github.com/huge-pancake/.arch/assets/73375859/b9f470bf-07ba-43d9-b522-81b22bcfab68)

</details>

<details>
<summary>WM Controller</summary>

![windows-manager-controller](https://github.com/huge-pancake/.arch/assets/73375859/04822d4d-1862-478c-b8b6-c6f546e8387c)

</details>

## Core/Desktop

| ~          | name       | command                                               |
| ---------- | ---------- | ----------------------------------------------------- |
| desktop    | Sway       | `paru -S sway`                                        |
|            | Hyprland   | `paru -S hyprland-git`                                |
| wallpaper  | hyprpaper  | `paru -S hyprpaper`                                   |
| launcher   | rofi       | `paru -S rofi-lbonn-wayland-git rofi-calc rofi-emoji` |
| notify     | mako       | `paru -S mako`                                        |
| bar        | waybar     | `paru -S waybar-hyprland-git`                         |
| idle       | swayidle   | `paru -S swayidle`                                    |
| locker     | swaylock   | `paru -S swaylock`                                    |
| screenshot | grimblast  | `paru -S grimblast`                                   |
| color pkr  | hyprpicker | `paru -S hyprpicker`                                  |
| ctrlers    | light      | `paru -S light && sudo chmod +s /bin/light`           |
|            | pamixer    | `paru -S pamixer`                                     |
|            | qt6ct      | `paru -S qt6ct`                                       |
| blue light | sunset     | `paru -S wlsunset`                                    |
| tray       | nm-applet  | `paru -S network-manager-applet`                      |
|            | blueman    | `paru -S blueman`                                     |
| wayland    | ...        | `paru -S qt5-wayland qt6-wayland`                     |

## Core/Non Desktop

| ~         | name      | command                                     |
| --------- | --------- | ------------------------------------------- |
| shell     | zsh       | `paru -S zsh && chsh -s /bin/zsh`           |
| units     |           | `paru -S zoxide ripgrep fd duf exa bat dog` |
| terminal  | foot      | `paru -S foot libsixel`                     |
| music     | mpd       | `paru -S mpd mpc ncmpcpp cava mpdscribble`  |
| file mgr  | ranger    | `paru -S ranger`                            |
|           | nemo      | `paru -S nemo`                              |
| sys fetch | fastfetch | `paru -S fastfetch`                         |

## Extra/Softwares

| ~      | name         | command                                                                                     |
| ------ | ------------ | ------------------------------------------------------------------------------------------- |
| IME    | fcitx5       | `paru -S fcitx5 fcitx5-chinese-addons fcitx5-anthy`                                         |
| editor | NeoVim       | `paru -S neovim-nightly-bin lazygit zoxide ripgrep sqlite fd yarn lldb make unzip`          |
|        | VSCode       | `paru -S visual-studio-code-bin`                                                            |
| NPM    | pnpm         | `paru -S pnpm`                                                                              |
| music  | MPD          | `paru -S mpd mpc ncmpcpp cava mpdscribble && systemctl enable --user --now mpdscribble mpd` |
|        | yesplaymusic | `paru -S yesplaymusic`                                                                      |

## Extra/Theme

| ~      | name       | command                              |
| ------ | ---------- | ------------------------------------ |
| cursor | Catppuccin | `paru -S catppuccin-cursors-mocha`   |
| gtk    | Catppuccin | `paru -S catppuccin-gtk-theme-mocha` |
| icons  | Papirus    | `paru -S papirus-icon-theme`         |
| qt     | (not yet)  | `paru -S ...`                        |

## Extra/Others

| ~         | name | command                                                              |
| --------- | ---- | -------------------------------------------------------------------- |
| dark mode | gtk4 | `gsettings set org.gnome.desktop.interface color-scheme prefer-dark` |

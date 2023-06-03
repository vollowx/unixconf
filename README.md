# arch-dotfiles

## Showcase

| music                                                                                                           | neovim                                                                                                          | something                                                                                                       | waybar themes                                                                                                   |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| ![image](https://user-images.githubusercontent.com/73375859/235141782-d715aadd-b9ec-46b8-ac48-8116c1280bad.png) | ![image](https://user-images.githubusercontent.com/73375859/235141863-79ae2da5-be11-489f-9a15-f8e40e0dbb14.png) | ![image](https://user-images.githubusercontent.com/73375859/235142039-8b2a77da-af5b-4d2c-9cd2-04389adc5f06.png) | ![image](https://user-images.githubusercontent.com/73375859/235142126-cadcece8-522d-4d58-86fb-27b12820ccea.png) |

## Quick Start

Core:

```sh
paru -S sway hyprland-git hyprpaper-git rofi-lbonn-wayland-git rofi-calc rofi-emoji\
        mako waybar-hyprland-git swayidle swaylock grimblast hyprpicker\
        light pamixer wlsunset network-manager-applet blueman\
        zsh zoxide ripgrep fd duf exa bat dog foot libsixel\
        mpd mpc ncmpcpp cava mpdscribble ranger nemo fastfetch
sudo chmod +s /bin/light
chsh -s /bin/zsh
```

QT:

```sh
paru -S qt6ct qt5-wayland qt6-wayland
```

Fcitx5:

```sh
paru -S fcitx5 fcitx5-chinese-addons fcitx5-anthy
```

## Core/Desktop

| ~          | name       | command                                               |
| ---------- | ---------- | ----------------------------------------------------- |
| desktop    | Hyprland   | `paru -S hyprland`                                    |
|            | Seay       | `paru -S sway`                                        |
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

| ~      | name         | command                                                                                                     |
| ------ | ------------ | ----------------------------------------------------------------------------------------------------------- |
| editor | NeoVim       | `paru -S neovim-nightly-bin lazygit zoxide ripgrep sqlite fd yarn lldb make unzip`                          |
|        | VSCode       | `paru -S code code-features`                                                                                |
| NPM    | pnpm         | `paru -S npm && sudo npm i -g pnpm && pnpm i -g pnpm && npm uninstall -g pnpm`                              |
| music  | MPD          | `paru -S mpd mpc ncmpcpp cava mpdscribble && systemctl enable --user --now mpdscribble.service mpd.service` |
|        | yesplaymusic | `paru -S yesplaymusic`                                                                                      |

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

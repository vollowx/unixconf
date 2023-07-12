# .unix

> Dotfiles for *nix systems.

## Showcase

![sway](https://github.com/vollowx/.unix/assets/73375859/ae2e2173-9f5a-4958-85b1-02238917ed5e)

<details>
<summary>Rofi</summary>

![rofi-launcher](https://github.com/vollowx/.unix/assets/73375859/52487b0f-3466-488c-a977-c7a2e3802133)
![rofi-session](https://github.com/vollowx/.unix/assets/73375859/5409195f-4c57-4303-b83c-5ef4e26955ef)

</details>

<details>
<summary>Music Playing</summary>

![musicfox](https://github.com/vollowx/.unix/assets/73375859/02e2a60a-53ca-4ed3-b50a-d0354bf346f5)

</details>

<details>
<summary>NeoVim</summary>

![neovim-lsp](https://github.com/vollowx/.unix/assets/73375859/15735ff9-5559-4c3d-818d-db08d5e02d4a)

</details>

<details>
<summary>WM Controller</summary>

![wmctl](https://github.com/vollowx/.unix/assets/73375859/4ab2dd63-5e0b-4b51-aa29-a16c24e9bda9)

</details>

## Installations

See [nullxception/dotfiles](https://github.com/nullxception/dotfiles)

<small>* For NeoVim configs, see [vollowx/.nvim](https://github.com/vollowx/.nvim)</small>

<small>* Waybar's theme is switchable, check their names at `wm/waybar/*.css,*.jsonc`, use `select-waybar-theme.sh [THEME_NAME]` (need `bin` module installed) to switch, and reload WM</small>

## Plans

- [ ] Add diff, sync back features for `dots.sh`
- [ ] Try `NixOS` at [vollowx/.nix](https://github.com/vollowx/.nix) in order to get easier environment configuating experiences
- [ ] Try `EWW`
- [ ] Replace `Rofi` with `Wofi`/`Tofi` or something else natively support `Wayland`

## Package List

### Core/Desktop

| ~          | name                 | command                           |
| ---------- | -------------------- | --------------------------------- |
| desktop    | sway (fx)            | `paru -S swayfx`                  |
|            | hyprland             | `paru -S hyprland-git`            |
| wallpaper  | hyprpaper            | `paru -S hyprpaper`               |
| launcher   | rofi                 | `paru -S rofi-lbonn-wayland-git`  |
|            | rofi (more)          | `paru -S rofi-calc rofi-emoji`    |
| notify     | mako                 | `paru -S mako`                    |
| bar        | waybar               | `paru -S waybar-hyprland-git`     |
| idle       | swayidle             | `paru -S swayidle`                |
| locker     | swaylock             | `paru -S swaylock`                |
| screenshot | grimshot (sway)      | `paru -S grimshot`                |
|            | grimblast (hyprland) | `paru -S grimblast`               |
| color pkr  | hyprpicker           | `paru -S hyprpicker`              |
| controller | light                | `paru -S light`                   |
|            | light (to enable)    | `sudo chmod +s /bin/light`        |
|            | pamixer              | `paru -S pamixer`                 |
|            | qt6ct                | `paru -S qt6ct`                   |
| blue light | sunset               | `paru -S wlsunset`                |
| tray       | nm-applet            | `paru -S network-manager-applet`  |
|            | blueman              | `paru -S blueman`                 |
| wayland    | ...                  | `paru -S qt5-wayland qt6-wayland` |

### Core/Sway Only

| ~        | name | command       |
| -------- | ---- | ------------- |
| overview | sov  | `paru -S sov` |

### Core/Non Desktop

| ~         | name            | command                                     |
| --------- | --------------- | ------------------------------------------- |
| shell     | zsh             | `paru -S zsh`                               |
|           | zsh (to enable) | `chsh -s /bin/zsh`                          |
| units     |                 | `paru -S zoxide ripgrep fd duf exa bat dog` |
| terminal  | foot            | `paru -S foot libsixel`                     |
| music     | mpd             | `paru -S mpd mpc ncmpcpp cava mpdscribble`  |
| file mgr  | ranger          | `paru -S ranger`                            |
|           | nemo            | `paru -S nemo`                              |
| sys fetch | fastfetch       | `paru -S fastfetch`                         |

### Extra/Softwares

| ~      | name            | command                                                         |
| ------ | --------------- | --------------------------------------------------------------- |
| IME    | fcitx5          | `paru -S fcitx5 fcitx5-chinese-addons fcitx5-anthy`             |
| editor | neovim          | `paru -S neovim-nightly-bin`                                    |
|        | neovim (more)   | `paru -S lazygit zoxide ripgrep sqlite fd yarn lldb make unzip` |
|        | neovim (GUI)    | `paru -S neovide-git-wayland`                                   |
|        | vscode          | `paru -S visual-studio-code-bin`                                |
| NPM    | pnpm            | `paru -S pnpm`                                                  |
| music  | mpd             | `paru -S mpd mpc ncmpcpp cava mpdscribble`                      |
|        | mpd (to enable) | `systemctl enable --user --now mpdscribble mpd`                 |
|        | yesplaymusic    | `paru -S yesplaymusic`                                          |
| calc   | qalculate       | `paru -S qalculate-gtk`                                         |

### Extra/Theme

| ~      | name       | command                              |
| ------ | ---------- | ------------------------------------ |
| cursor | MacOS      | `paru -S apple_cursor`               |
| gtk    | Catppuccin | `paru -S catppuccin-gtk-theme-mocha` |
| icons  | Papirus    | `paru -S papirus-icon-theme`         |
| qt     | (not yet)  | `paru -S ...`                        |

### Extra/Others

| ~         | name | command                                                              |
| --------- | ---- | -------------------------------------------------------------------- |
| dark mode | gtk4 | `gsettings set org.gnome.desktop.interface color-scheme prefer-dark` |

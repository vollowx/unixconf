# .unix

_Dotfiles for *nix systems. Use at your own risks._

## Installations

```sh
# To link a module
stow module_name
# To unlink a module
stow -D module_name
```

Note that if some files/folders is/are deleted, you will need to delete the link manually.
Similarly, if some is/are added, rerun the link command.

## Modules

`cli` `neovim` `gui` `niri` / `sway` `wayfire` `deprecated`

### `cli`

CLI tool configurations.

- `bat` - `cat`
- `dust` - `du`
- `eza` - `ls`
- `htop` - `top`
- `fish` - Shell
- `pfetch` - System info viewer
- `mpd` - Music server
- `ncmpcpp` - Music player
- `cava` - Audio visualizer
- `bin` scripts

### `gui`

GUI application configurations that is shared across all WMs or DEs.

- `alacritty` - Terminal emulator
- `anyrun` - Application launcher
- `dunst` - Notification daemon
- `swaylock` - Screen locker
- `zathura` - PDF viewer
- `fontconfig`
- `qt5ct`
- `qt6ct`
- `gtk-3.0`
- `electron` flags
- `mimeapps`
- `macOS` cursors

### `neovim`

It's separated from `cli` module because the Neovim configuration is quite massive.

- `neovim` - Text editor

### `niri`

- `niri` - Window manager
- `waybar` - Screen bar
- `sysbar` - Screen OSD

### `sway` (unmaintained)

- `sway` - Window manager

### `wayfire` (unmaintained)

- `wayfire` - Window manager

### `deprecated` (unmaintained)

- `foot` - Terminal emulator

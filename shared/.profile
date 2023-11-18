export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR=$EDITOR
export MANPAGER="nvim +Man!"
export BROWSER="qutebrowser"
export TERMINAL="kitty"

export QT_QPA_PLATFORM="wayland;xcb"
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER="wayland,x11"
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_ENABLE_WAYLAND=1

export GTK2_RC_FILES=~/.config/gtk-2.0/gtkrc

export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME=gtk2

export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

export BAT_THEME="Catppuccin-mocha"
export NEOVIDE_MULTIGRID=true
export PF_INFO="ascii title os host kernel uptime pkgs memory de shell editor palette"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

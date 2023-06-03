#!/usr/bin/env bash

bold="\e[29;1m"

choise="$1"

case "$choise" in
"--help" | "-h")
	echo $'\e[29;1mUsage:  wm-do.sh [OPTIONS] [COMMAND]\e[0m'
	echo ""
	echo $'\e[29;1mOptions:\e[0m'
	echo "  -h, --help:                         Show this help text"
	echo ""
	echo $'\e[29;1mCommands:\e[0m'
	echo "  volume_up, v+:                      Turn up the volume"
	echo "  volume_down, v-:                    Turn down the volume"
	echo "  volume_toggle, vm:                  Toggle mute of the volume"
	echo "  brightness_up, b+:                  Turn up the brightness"
	echo "  brightness_down, b-:                Turn down the brightness"
	echo "  screenshot_copy_area, sca:          Take a area screenshot and copy"
	echo "  screenshot_copy_save_area, scsa:    Take a area screenshot, copy and save"
	echo "  screenshot_copy_save_screen, scss:  Take a screen screenshot, copy and save"
	echo "  mako_toggle, mt:                    Toggle Mako's do-not-disturb mode"
	echo "  sway_launch, s~                     Launch Sway"
	echo "  hyprland_reload, hr:                Reload Hyprland and components under it"
	echo "  hyprland_low_toggle, hlt:           Toggle Hyprland's low graphics quality mode"
	;;
"volume_up" | "v+")
	pamixer -i 2
	notify-send "󰕾  Volume" "Volume: $(pamixer --get-volume)%" --hint="int:value:$(pamixer --get-volume)"
	;;
"volume_down" | "v-")
	pamixer -d 2
	notify-send "󰕾  Volume" "Volume: $(pamixer --get-volume)%" --hint="int:value:$(pamixer --get-volume)"
	;;
"volume_mute" | "vm")
	pamixer -t
	notify-send "󰕾  Volume" "Mute: $(pamixer --get-mute)" --hint="int:value:$(pamixer --get-volume)"
	;;
"brightness_up" | "b+")
	light -A 5
	notify-send "󰃠  Brightness" "Brightness: $(light)%" --hint="int:value:$(light)"
	;;
"brightness_down" | "b-")
	light -U 5
	notify-send "󰃠  Brightness" "Brightness: $(light)%" --hint="int:value:$(light)"
	;;
"screenshot_copy_area" | "sca")
	grimblast copy area
	notify-send '󰹑  Screenshot' 'Area copied'
	;;
"screenshot_copy_save_screen" | "scss")
	grimblast copysave screen $(xdg-user-dir PICTURES)/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
	notify-send '󰹑  Screenshot' 'Screen copied and saved'
	;;
"screenshot_copy_save_area" | "scsa")
	grimblast copysave area $(xdg-user-dir PICTURES)/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
	notify-send '󰹑  Screenshot' 'Area copied and saved'
	;;
"mako_toggle" | "mt")
	MAKO_MODE=$(makoctl mode)
	if [ $MAKO_MODE = "do-not-disturb" ]; then
		makoctl set-mode default
		notify-send '󱏧  Do Not Disturb' 'Do-Not-Disturb mode - OFF' --hint="int:value:0.00"
	else
		notify-send '󱏧  Do Not Disturb' 'Do-Not-Disturb mode - BEING ON' --hint="int:value:100.00"
		sleep 2
		makoctl set-mode do-not-disturb
	fi
	;;
"sway_launch" | "s~")
	# Wlroots
	# export WLR_RENDERER=vulkan
	export WLR_NO_HARDWARE_CURSORS=1

	# Wayland
	export QT_QPA_PLATFORM=wayland
	export SDL_VIDEODRIVER=wayland
	export CLUTTER_BACKEND=wayland

	# Firefox
	export MOZ_ENABLE_WAYLAND=1
	export MOZ_WEBRENDER=1

	# QT
	export QT_AUTO_SCREEN_SCALE_FACTOR=1
	export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
	export QT_QPA_PLATFORMTHEME=qt6ct

	# Java
	export _JAVA_AWT_WM_NONREPARENTING=1

	# FCITX
	export GLFW_IM_MODULE=fcitx
	export GTK_IM_MODULE=fcitx
	export INPUT_METHOD=fcitx
	export XMODIFIERS=@im=fcitx
	export IMSETTINGS_MODULE=fcitx
	export QT_IM_MODULE=fcitx

	sway -V
	;;
"hyprland_reload" | "hr")
	pkill mako
	pkill waybar
	pkill hyprpaper
	pkill wl-sunset
	hyprctl reload
	fc-cache
	mako &
	waybar &
	hyprpaper &
	wlsunset -l 39.9 -L 116.3 &
	notify-send "󰖌  Hyprland" "Reloaded successful"
	;;
"hyprland_low_toggle" | "hlt")
	HYPR_LOW_MODE=$(hyprctl getoption animations:enabled | sed -n '2p' | awk '{print $2}')
	if [ $HYPR_LOW_MODE = 1 ]; then
		hyprctl --batch "\
      keyword animations:enabled 0;\
      keyword decoration:drop_shadow 0;\
      keyword decoration:blur 0"
		notify-send "󰖌  Hyprland" "Low graphics quality mode - ON" --hint="int:value:100.00"
		exit
	else
		notify-send "󰖌  Hyprland" "Low graphics quality mode - OFF" --hint="int:value:0.00"
	fi
	hyprctl reload
	;;
esac

#!/bin/bash

user_select="$(cliphist list | rofi -dmenu -theme ~/.config/rofi/launcher.rasi)"

if [[ ! -z $user_select ]]; then
	echo "$user_select" | cliphist decode | wl-copy
fi

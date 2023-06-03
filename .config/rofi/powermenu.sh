#!/bin/bash

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

# Options
shutdown='󰤂 Shutdown'
reboot='󰜉 Reboot'
lock='󰌾 Lock'
sleep='󰤄 Sleep'
suspend='󰍛 Mem'
hibernate='󰾶 Swap'
logout='󰍃 Logout'
yes='󰄬 Yes'
no='󰅖 No'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme ~/.config/rofi/powermenu.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ~/.config/rofi/powermenu.rasi
}

# Sleep CMD
sleep_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Sleeping' \
		-mesg 'Where to Sleep?' \
		-theme ~/.config/rofi/powermenu.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Ask for where to sleep
sleep_to() {
	echo -e "$suspend\n$hibernate" | sleep_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$sleep\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl suspend
		elif [[ $1 == '--hibernate' ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl hibernate
		elif [[ $1 == '--logout' ]]; then
			session=$(loginctl session-status | head -n 1 | awk '{print $1}')
			loginctl terminate-session "$session"
		fi
	else
		exit 0
	fi
}

run_sleep_cmd() {
	selected="$(sleep_to)"
	if [[ "$selected" == "$suspend" ]]; then
		run_cmd --suspend
	elif [[ "$selected" == "$hibernate" ]]; then
		run_cmd --hibernate
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
	run_cmd --shutdown
	;;
$reboot)
	run_cmd --reboot
	;;
$lock)
	sleep 0.05
	swaylock
	;;
$sleep)
	run_sleep_cmd
	;;
$logout)
	run_cmd --logout
	;;
esac

#!/usr/bin/env bash

date=$(date +'%A, %#d %B %H:%M')
battery=$(echo "$(cat /sys/class/power_supply/BAT0/capacity)%")
battery_status=$(cat /sys/class/power_supply/BAT0/status)
echo $battery_status
# both Charging and Full are considered charging
if [ $battery_status = 'Charging' ]; then
  battery_status=' (charging)'
elif [ $battery_status = 'Full' ]; then
  battery_status=' (charging)'
else
  battery_status=''
fi
wifi=$(nmcli device show wlp0s20f3 | rg --replace '' 'GENERAL.CONNECTION:                     ')

notify-send -r 69 \
  -a "${date}" "Battery at $battery$battery_status" "Connected to $wifi" \
  -h int:value:"$battery" \
  -t 888 \
  -u low

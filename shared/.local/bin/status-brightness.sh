#!/usr/bin/env bash

brightnessctl "$@"
brightness=$(echo $(($(brightnessctl g) * 100 / $(brightnessctl m))))

notify-send -r 69 \
  -a "Brightness" "Currently at $brightness%" \
  -h int:value:"$brightness" \
  -t 888 \
  -u low
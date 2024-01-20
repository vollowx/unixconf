#!/usr/bin/env bash

pamixer "$@"
volume="$(pamixer --get-volume-human)"

if [ "$volume" = "muted" ]; then
  notify-send -r 69 \
    -a "Volume" \
    "Muted" \
    -t 888 \
    -u low
else
  notify-send -r 69 \
    -a "Volume" "Currently at $volume" \
    -h int:value:"$volume" \
    -t 888 \
    -u low
fi

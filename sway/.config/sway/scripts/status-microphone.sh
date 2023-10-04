#!/usr/bin/env bash

pamixer --default-source "$@"
mic="$(pamixer --default-source --get-volume-human)"

if [ "$mic" = "muted" ]; then
  notify-send -r 69 \
    -a "Microphone" \
    "Muted" \
    -t 888 \
    -u low
else
  notify-send -r 69 \
    -a "Microphone" "Currently at $mic" \
    -h int:value:"$mic" \
    -t 888 \
    -u low
fi

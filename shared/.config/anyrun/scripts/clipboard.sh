#!/usr/bin/env bash

selected=$(cliphist list | anyrun --plugins libstdin.so --max-entries 100)

if [ ! -z "$selected" ]; then
	cliphist decode <<<"$selected" | wl-copy
fi

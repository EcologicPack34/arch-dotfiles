#!/bin/sh

hyprctl dispatch togglefloating

active_window=$(hyprctl activewindow -j)
is_floating=$(echo "$active_window" | jq .floating)

if [ "$is_floating" = "true" ]; then
	hyprctl dispatch resizeactive "$@"
	hyprctl dispatch centerwindow
fi

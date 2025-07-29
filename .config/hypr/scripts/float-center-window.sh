#!/bin/sh

hyprctl dispatch togglefloating

ACTIVE_WINDOW=$(hyprctl activewindow -j)
IS_FLOATING=$(echo "$ACTIVE_WINDOW" | jq .floating)

if [ "$IS_FLOATING" = "true" ]; then
	hyprctl dispatch resizeactive "$@"
	hyprctl dispatch centerwindow
fi

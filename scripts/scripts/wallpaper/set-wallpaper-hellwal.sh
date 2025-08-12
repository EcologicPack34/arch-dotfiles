#!/bin/bash

ARG="$1"
SET_WALLPAPER_SCRIPT="$HOME/scripts/wallpaper/set-wallpaper.sh"
WALLPAPER_OUTPUT="$HOME/.cache/wallpaper"

if [ -f  "$ARG" ]; then
	$SET_WALLPAPER_SCRIPT "$ARG"
	hellwal -i "$ARG" -m 
elif [ -d "$ARG" ]; then
	echo "Working on it!"
else
	echo ""$ARG" does not exist" >&2
	exit 1
fi

systemctl --user restart waybar

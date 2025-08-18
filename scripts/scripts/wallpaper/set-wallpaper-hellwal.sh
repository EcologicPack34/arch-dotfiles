#!/bin/bash

SET_WALLPAPER_SCRIPT="$HOME/scripts/wallpaper/set-wallpaper.sh"
WALLPAPER_OUTPUT="$HOME/.cache/wallpaper"

if [ $# -eq 1 ]; then
	CHOSEN_WALLPAPER="$1"
else
	# Choose a random wallpaper if more than one argument passed
	POSSIBLE_WALLPAPERS=("$@")
	CHOSEN_WALLPAPER="${POSSIBLE_WALLPAPERS[RANDOM % $#]}"
fi

if [ -f  "$CHOSEN_WALLPAPER" ]; then
	$SET_WALLPAPER_SCRIPT "$CHOSEN_WALLPAPER"
	hellwal -i "$CHOSEN_WALLPAPER" -m
elif [ -d "$CHOSEN_WALLPAPER" ]; then
	echo "Working on it!"
else
	echo ""$CHOSEN_WALLPAPER" does not exist" >&2
	exit 1
fi

systemctl --user restart waybar

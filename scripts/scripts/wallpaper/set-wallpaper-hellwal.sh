#!/bin/bash

set_wallpaper_script="$HOME/scripts/wallpaper/set-wallpaper.sh"
wallpaper_output="$HOME/.cache/wallpaper"

if [ $# -eq 1 ]; then
	chosen_wallpaper="$1"
else
	# Choose a random wallpaper if more than one argument passed
	possible_wallpaper=("$@")
	chosen_wallpaper="${possible_wallpaper[RANDOM % $#]}"
fi

if [ -f  "$chosen_wallpaper" ]; then
	$set_wallpaper_script "$chosen_wallpaper"
	hellwal -i "$chosen_wallpaper" -m
elif [ -d "$chosen_wallpaper" ]; then
	echo "Working on it!"
else
	echo ""$chosen_wallpaper" does not exist" >&2
	exit 1
fi

systemctl --user restart waybar

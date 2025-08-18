#!/bin/bash

WALLPAPER_OUTPUT=~/.cache/wallpaper/
WALLPAPER_OUTPUT_FILE="$WALLPAPER_OUTPUT"/"current_wallpaper"
mkdir "$WALLPAPER_OUTPUT" -p

if [ $# -eq 1 ]; then
	CHOSEN_WALLPAPER="$1"
else
	# Choose a random wallpaper if more than one argument passed
	POSSIBLE_WALLPAPERS=("$@")
	CHOSEN_WALLPAPER="${POSSIBLE_WALLPAPERS[RANDOM % $#]}"
fi

# In case the wallpaper's set elsewhere,
# check the environment variable
SET_WALLPAPER="${SET_WALLPAPER:-yes}" 

[ -f "$CHOSEN_WALLPAPER" ] || {
	echo "$CHOSEN_WALLPAPER does not exist" >&2
	exit 1 
}

[ "$SET_WALLPAPER" = "yes" ] && swww img "$CHOSEN_WALLPAPER" --transition-type any --transition-fps 60 --transition-duration 2
cp "$CHOSEN_WALLPAPER" "$WALLPAPER_OUTPUT_FILE"
magick "$WALLPAPER_OUTPUT_FILE" -colorspace Gray "$WALLPAPER_OUTPUT_FILE"_grayscale

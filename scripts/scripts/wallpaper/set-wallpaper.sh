#!/bin/bash

WALLPAPER_OUTPUT=~/.cache/wallpaper/
WALLPAPER_OUTPUT_FILE="$WALLPAPER_OUTPUT"/"current_wallpaper"
mkdir "$WALLPAPER_OUTPUT" -p

CHOSEN_WALLPAPER="$1"
SET_WALLPAPER="${SET_WALLPAPER:-yes}" # In case the wallpaper's set elsewhere

[ -f "$CHOSEN_WALLPAPER" ] || {
	echo "$CHOSEN_WALLPAPER does not exist" >&2
	exit 1 
}

[ "$SET_WALLPAPER" = "yes" ] && swww img "$CHOSEN_WALLPAPER" --transition-type any --transition-fps 60 --transition-duration 2
cp "$CHOSEN_WALLPAPER" "$WALLPAPER_OUTPUT_FILE"
magick "$WALLPAPER_OUTPUT_FILE" -colorspace Gray "$WALLPAPER_OUTPUT_FILE"_grayscale

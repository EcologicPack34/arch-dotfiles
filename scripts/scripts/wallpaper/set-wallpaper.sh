#!/bin/bash

wallpaper_output=~/.cache/wallpaper/
wallpaper_output_file="$wallpaper_output"/"current_wallpaper"
mkdir "$wallpaper_output" -p

if [ $# -eq 1 ]; then
	chosen_wallpaper="$1"
else
	# Choose a random wallpaper if more than one argument passed
	possible_wallpapers=("$@")
	chosen_wallpaper="${possible_wallpapers[RANDOM % $#]}"
fi

# In case the wallpaper's set elsewhere,
# check the environment variable
set_wallpaper="${set_wallpaper:-yes}" 

[ -f "$chosen_wallpaper" ] || {
	echo "$chosen_wallpaper does not exist" >&2
	exit 1 
}

[ "$set_wallpaper" = "yes" ] && swww img "$chosen_wallpaper" --transition-type any --transition-fps 60 --transition-duration 2
cp "$chosen_wallpaper" "$wallpaper_output_file"
magick "$wallpaper_output_file" -colorspace Gray "$wallpaper_output_file"_grayscale

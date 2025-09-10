#!/bin/bash

set_wallpaper_script="$HOME/scripts/wallpaper/set-wallpaper.sh"
data_folder="$HOME/scripts/wallpaper/data"
wallpaper_output="$HOME/.cache/wallpaper"
hellwal_themes_folder="$HOME/.config/hellwal/themes"

if [ $# -eq 1 ]; then
	chosen_wallpaper="$1"
else
	# Choose a random wallpaper if more than one argument passed
	possible_wallpaper=("$@")
	chosen_wallpaper="${possible_wallpaper[RANDOM % $#]}"
fi

[ ! -f "$chosen_wallpaper" ] && {
	echo ""$chosen_wallpaper" does not exist" >&2
	exit 1
}

# The args file is just the wallpaper's name with .args at the end
# It should contain just a line of arguments to be passed to hellwal
# If none found with the wallpaper's name, the default file located at this script's data folder is used
args_file="$chosen_wallpaper".args
[ ! -f "$args_file" ] && args_file="$data_folder/default.args"

# Look for the hellwal theme in the hellwal themes folder instead of the wallpaper folder
wallpaper_name="$(basename "$chosen_wallpaper")"
hellwal_theme="$hellwal_themes_folder"/"$wallpaper_name".hellwal

$set_wallpaper_script "$chosen_wallpaper"

if [ -f "$hellwal_theme" ]; then
	hellwal --theme "$hellwal_theme"
else
	hellwal -i "$chosen_wallpaper" $(< $args_file)
fi

systemctl --user restart waybar

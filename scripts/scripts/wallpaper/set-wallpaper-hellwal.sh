#!/bin/bash

set_wallpaper_script="$HOME/scripts/wallpaper/set-wallpaper.sh"
data_folder="$HOME/scripts/wallpaper/data"
wallpaper_output="$HOME/.cache/wallpaper"

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

# Get the basename for the image file and  to later add our custom ones
wallpaper_basename="$(basename $chosen_wallpaper)"
echo $wallpaper_basename

# The args file is just the wallpaper's name with .args at the end
# It should contain just a line of arguments to be passed to hellwal
# If none found with the wallpaper's name, the default file located at this script's data folder is used
args_file="$wallpaper_basename".args
[ ! -f "$args_file" ] && args_file="$data_folder/default.args"

$set_wallpaper_script "$chosen_wallpaper"
hellwal -i "$chosen_wallpaper" $(< $args_file)

systemctl --user restart waybar

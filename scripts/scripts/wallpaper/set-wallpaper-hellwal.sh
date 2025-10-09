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

# The args file is just the wallpaper's name with .args at the end in the themes folder
# It should contain just a line of arguments to be passed to hellwal
# If none found with the wallpaper's name, the default file located at this script's data folder is used
wallpaper_name="$(basename "$chosen_wallpaper")"
args_file="$hellwal_themes_folder"/"$wallpaper_name".args
[ ! -f "$args_file" ] && args_file="$data_folder/default.args"

hellwal_theme="$hellwal_themes_folder"/"$wallpaper_name".hellwal

$set_wallpaper_script "$chosen_wallpaper"

if [ -f "$hellwal_theme" ]; then
	hellwal --theme "$hellwal_theme"
else
	hellwal -i "$chosen_wallpaper" $(< $args_file)
fi

# This changes the cursor color to the default one
for tty in /dev/pts/*; do
	# Ignore terminals we don't have permission to write to
	[ -w "$tty" ] || continue
	printf "\e]112\a" > "$tty"
done


# RESTARTING SERVICES
systemctl --user restart waybar
pkill -USR1 cava

# For some reason I need to send this to kitty as well when
# cava is running on a terminal since it won't reload the 
# colors automatically.
pkill -USR1 kitty

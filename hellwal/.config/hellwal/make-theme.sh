#!/bin/bash

hellwal_cache="$HOME/.cache/hellwal"
wallpaper_cache="$HOME/.cache/wallpaper"
theme_name="$1"

[ -z "$theme_name" ] && {
	echo "Theme name necessary" >&2
	exit 1;
}

# 0. Check if theme already exists
# 1. Create folder with theme name in hellwal/themes/ (theme_name/)
# 2. Copy the image to the theme folder with the correct name (theme_name.jpg)
# 3. Copy the args file, if any, to the theme folder with the correct name (theme_name.jpg.args) -- Unnecessary
# 4. Copy the hellwal colors from cache to the theme folder with the correct name (theme_name.jpg.hellwal)
# 4.1. Possibly format the colors file properly with newlines
themes_folder="$HOME/.config/hellwal/themes"
current_theme_folder="$themes_folder"/"$theme_name"

# [ -d "$current_theme_folder" ] && {
# 	echo "Theme '$theme_name' already exists" >&2
# 	exit 1;
# }

mkdir "$current_theme_folder"

# Store the image extension, in case some scripts may use it
image_file="$(realpath <<< readlink "$wallpaper_cache"/"current_wallpaper")"
image_extension="${image_file##*.}"

cp "$wallpaper_cache"/"current_wallpaper" "$current_theme_folder"/"$theme_name"."$image_extension"

# Copy and prettify the hellwal colors file, filtering out any unnecessary data
sed 's/%%%%/%%\n%%/g' "$hellwal_cache"/"colors.hellwal" |\
grep -vE "background|border|wallpaper|cursor|foreground" > "$current_theme_folder"/"$theme_name"."$image_extension"."hellwal"

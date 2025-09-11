#!/bin/bash

hellwal_cache="$HOME/.cache/hellwal"
wallpaper_cache="$HOME/.cache/wallpaper"
hellwal_themes="$HOME/.config/hellwal/themes"

image_file="$(realpath <<< readlink "$wallpaper_cache"/"current_wallpaper")"
image_name="$(basename $image_file)"

# Copy and prettify the hellwal colors file, filtering out any unnecessary data
sed 's/%%%%/%%\n%%/g' "$hellwal_cache"/"colors.hellwal" |\
grep -vE "background|border|wallpaper|cursor|foreground" > "$hellwal_themes"/"$image_name"."hellwal"

#!/bin/bash

day_code="$(date +"%Y%m%d")"
daily_waifu_dir="$HOME/.cache/waifu"
daily_waifu_file="$daily_waifu_dir/daily_$day_code"

mkdir -p "$daily_waifu_dir"

# If the daily waifu is not found, download a new one
if [ ! -f "$daily_waifu_file" ]; then
	rm -f -- "$daily_waifu_dir"/daily_*
	file="$(~/scripts/waifu/waifu.sh "$@")" || exit 1
	mv "$file" "$daily_waifu_file"
fi

echo "$daily_waifu_file"

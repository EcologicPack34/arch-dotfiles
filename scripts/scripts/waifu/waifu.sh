#!/bin/bash

current_dir="$(dirname $(realpath "${BASH_SOURCE[0]}"))"

waifu_file="/tmp/waifu"
api_url="https://api.waifu.pics"
type="${1:-sfw}"
category="${2:-waifu}"

valid_types_file="$current_dir/data/valid_types.txt"

[ "$type" = "random" ] && type="$(shuf -n 1 "$valid_types_file")"

if ! grep -Fxq "$type" "$valid_types_file"; then
	echo "NOT A VALID type" >&2
	cat "$valid_types_file" >&2
	exit 1
fi

valid_categories_file="$current_dir/data/categories_$type.txt"

[ "$category" = "random" ] && category="$(shuf -n 1 "$valid_categories_file")"

if ! grep -Fxq "$category" "$valid_categories_file"; then
	echo "NOT A VALID category" >&2
	cat "$valid_categories_file" >&2
	exit 1
fi

endpoint="$api_url/$type/$category"
result="$(curl -s "$endpoint"  | jq -er '.url')" || {
	echo "Could not get image from "$endpoint"" >&2
	exit 1
}

curl "$result" -s  -o "$waifu_file" || {
	echo "Could not download image "$result" into "$waifu_file"" >&2
	exit 1
}

echo "$type" "$category" >&2

setfattr "$waifu_file" -n user.category -v "$category" 
echo $waifu_file

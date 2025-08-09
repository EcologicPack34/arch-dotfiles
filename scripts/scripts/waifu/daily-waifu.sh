#!/bin/bash

DAY_CODE="$(date +"%Y%m%d")"
DAILY_WAIFU_DIR="/tmp/waifu"
DAILY_WAIFU_FILE="$DAILY_WAIFU_DIR/$DAY_CODE"
mkdir -p "$DAILY_WAIFU_DIR"

# If the daily waifu is not found, download a new one
if [ ! -f "$DAILY_WAIFU_FILE" ]; then
	rm -f -- "$DAILY_WAIFU_DIR"/*
	URL="$(~/scripts/waifu/waifu.sh "$@")" || exit 1
	curl "$URL" -s -o "$DAILY_WAIFU_FILE"
fi

echo "$DAILY_WAIFU_FILE"

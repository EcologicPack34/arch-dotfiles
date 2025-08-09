#!/bin/bash

CURRENT_DIR="$(dirname $(realpath "${BASH_SOURCE[0]}"))"

API_URL="https://api.waifu.pics"
TYPE="${1:-sfw}"
CATEGORY="${2:-waifu}"

VALID_TYPES_FILE="$CURRENT_DIR/data/valid_types.txt"

[ "$TYPE" = "random" ] && TYPE="$(shuf -n 1 "$VALID_TYPES_FILE")"

if ! grep -Fxq "$TYPE" "$VALID_TYPES_FILE"; then
	echo "NOT A VALID TYPE" >&2
	cat "$VALID_TYPES_FILE" >&2
	exit 1
fi

VALID_CATEGORIES_FILE="$CURRENT_DIR/data/categories_$TYPE.txt"

[ "$CATEGORY" = "random" ] && CATEGORY="$(shuf -n 1 "$VALID_CATEGORIES_FILE")"

if ! grep -Fxq "$CATEGORY" "$VALID_CATEGORIES_FILE"; then
	echo "NOT A VALID CATEGORY" >&2
	cat "$VALID_CATEGORIES_FILE" >&2
	exit 1
fi

ENDPOINT="$API_URL/$TYPE/$CATEGORY"
RESULT="$(curl -s "$ENDPOINT"  | jq -er '.url')" || {
	echo "Could not get image from "$ENDPOINT"" >&2
	exit 1
}
echo "$TYPE" "$CATEGORY" >&2
echo $RESULT

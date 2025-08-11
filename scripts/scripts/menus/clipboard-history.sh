#!/bin/bash

HISTORY="$(cliphist list)"

if [ -z "$HISTORY" ]; then
	fuzzel --dmenu -l 0 -p "Clipboard empty" --keyboard-focus on-demand
	exit 0;
fi

LINES="$(echo "$HISTORY" | wc -l)"
LINES_CAP=38
[ "$LINES" -gt "$LINES_CAP" ] && LINES="$LINES_CAP"

EXTRA_LENGTH=6
MAX_LENGTH="$(awk -v extra="$EXTRA_LENGTH" '{ if (length > max) max = length } END { print max+extra }' <<< "$HISTORY")"
LENGTH_CAP=100

[ "$MAX_LENGTH" -gt "$LENGTH_CAP" ] && MAX_LENGTH="$LENGTH_CAP"

SELECTION="$(echo -e "$HISTORY\n:clear" | fuzzel --dmenu -l "$LINES" -w "$MAX_LENGTH")"

[ -z "$SELECTION" ] && exit 1;
if [ "$SELECTION" == ":clear" ]; then
	notify-send "History cleared"
	cliphist wipe
	exit 0;
fi

echo "$SELECTION" | cliphist decode | wl-copy

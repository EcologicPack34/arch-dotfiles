#!/bin/bash

HISTORY="$(cliphist list)"

if [ -z "$HISTORY" ]; then
	fuzzel --dmenu -l 0 -p "Clipboard empty"
	exit 0;
fi

LINES="$(echo "$HISTORY" | wc -l)"

MAX_LENGTH=$(echo "$HISTORY" | awk '{ if (length > max) max = length } END { print max }')
CAP=100

if [ "$MAX_LENGTH" -gt "$CAP" ]; then
  MAX_LENGTH="$CAP"
fi

SELECTION="$(echo -e "$HISTORY\n:clear" | fuzzel --dmenu -l "$LINES" -w "$MAX_LENGTH")"

[ -z "$SELECTION" ] && exit 1;
if [ "$SELECTION" == ":clear" ]; then
	notify-send "History cleared"
	cliphist wipe
	exit 0;
fi

echo "$SELECTION" | cliphist decode | wl-copy

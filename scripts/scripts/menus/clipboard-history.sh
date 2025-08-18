#!/bin/bash

HISTORY="$(cliphist list)"

if [ -z "$HISTORY" ]; then
	fuzzel --dmenu -l 0 -p "Clipboard empty" --keyboard-focus on-demand
	exit 0;
fi

LINES="$(echo "$HISTORY" | wc -l)"
LINES_CAP=38
[ "$LINES" -gt "$LINES_CAP" ] && LINES="$LINES_CAP"

MAX_LENGTH=$(awk -v extra=6 -v min=20 -v cap=100 '{ if (length > max) max = length } END { m = max + extra; if (m > cap) m = cap; if (m < min) m = min; print m }' <<< "$HISTORY")

SELECTION="$(echo -e "$HISTORY\n:clear" | fuzzel --dmenu -l "$LINES" -w "$MAX_LENGTH" -p "copy: ")"

[ -z "$SELECTION" ] && exit 1;
if [ "$SELECTION" == ":clear" ]; then
	notify-send "Clipboard cleared"
	cliphist wipe
	exit 0;
fi

echo "$SELECTION" | cliphist decode | wl-copy

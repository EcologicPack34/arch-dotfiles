#!/bin/bash

history="$(cliphist list)"

if [ -z "$history" ]; then
	fuzzel --dmenu -l 0 -p "Clipboard empty" --keyboard-focus on-demand
	exit 0;
fi

lines="$(echo "$history" | wc -l)"
lines_cap=38
[ "$lines" -gt "$lines_cap" ] && lines="$lines_cap"

max_length=$(awk -v extra=6 -v min=20 -v cap=100 '{ if (length > max) max = length } END { m = max + extra; if (m > cap) m = cap; if (m < min) m = min; print m }' <<< "$history")

selection="$(echo -e "$history\n:clear" | fuzzel --dmenu -l "$lines" -w "$max_length" -p "copy: ")"

[ -z "$selection" ] && exit 1;
if [ "$selection" == ":clear" ]; then
	notify-send "Clipboard cleared"
	cliphist wipe
	exit 0;
fi

echo "$selection" | cliphist decode | wl-copy

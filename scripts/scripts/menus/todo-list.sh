#!/bin/bash

todo_file="$(xdg-user-dir DOCUMENTS)/todo.txt"

[ -f "$todo_file" ] || touch "$todo_file";

while true; do
	items="$(cat "$todo_file")"
	count="$(echo "$items" | wc -l)"

	[ -z "$items" ] && count=0;

	width="$(awk -v extra=6 -v min=50 -v cap=100 '{ if (length > max) max = length } END { m = max + extra; if (m > cap) m = cap; if (m < min) m = min; print m }' <<< "$items")"
		

	selection="$(echo "$items" | fuzzel --dmenu -w "$width" -l "$count" -p "// ")"

	[ -z "$selection" ] && exit 1;

	# Fx matches the entire line for the exact string
	if grep -Fxq "$selection" <<< "$items"; then
		grep -Fxv "$selection" <<< "$items" > "$todo_file"
	else
		echo "$selection" >> "$todo_file"
	fi
done

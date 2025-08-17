#!/bin/bash

ACTION="$(printf "mount\nunmount\npower-off" | fuzzel -l 3 --dmenu -p "udisksctl: ")"

[ -z "$ACTION" ] && exit 1;

DRIVE="$(lsblk -lo PATH,SIZE,LABEL,MOUNTPOINTS,TYPE |
grep "part" | sed -r 's/\s+\S+$//' |
grep -v " /boot" |
grep -v " /$" |
fuzzel --dmenu -l 30 -p "$ACTION: "  -w 70)"


[ -z "$DRIVE" ] && exit 1;
DRIVE="$(echo "$DRIVE" | awk '{print $1}')"

OUTPUT="$(udisksctl "$ACTION" -b "$DRIVE" 2>&1)"
STATUS="$?"

[ -z "$OUTPUT" ] && OUTPUT="OK"

if [ "$STATUS" = 0 ]; then
	notify-send "Udisksctl" "$OUTPUT"
else
	notify-send "Udisksctl" "$OUTPUT" -u critical
fi

#!/bin/bash

action="$(printf "mount\nunmount\npower-off" | fuzzel -l 3 --dmenu -p "udisksctl: ")"

[ -z "$action" ] && exit 1;

drive="$(lsblk -lo PATH,SIZE,LABEL,MOUNTPOINTS,TYPE |
grep "part" | sed -r 's/\s+\S+$//' |
grep -v " /boot" |
grep -v " /$" |
fuzzel --dmenu -l 30 -p "$action: "  -w 70)"


[ -z "$drive" ] && exit 1;
drive="$(echo "$drive" | awk '{print $1}')"

output="$(udisksctl "$action" -b "$drive" 2>&1)"
status="$?"

[ -z "$output" ] && output="OK"

if [ "$status" = 0 ]; then
	notify-send "Udisksctl" "$output"
else
	notify-send "Udisksctl" "$output" -u critical
fi

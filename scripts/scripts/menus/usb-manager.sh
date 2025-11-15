#!/bin/bash

action="$(printf "mount\nunmount\npower-off\neject" | fuzzel -l 4 --dmenu -p "udisksctl: ")"

[ -z "$action" ] && exit 1;

drive="$(lsblk -lo PATH,SIZE,LABEL,MOUNTPOINTS,TYPE |
grep "part" | sed -r 's/\s+\S+$//' |
grep -v " /boot" |
grep -v " /$" |
fuzzel --dmenu -l 30 -p "$action: "  -w 70)"


[ -z "$drive" ] && exit 1;
drive="$(echo "$drive" | awk '{print $1}')"

# Special case for eject, to not forget that I need to both unmount and power the thing off
if [ "$action" = "eject" ]; then
	output="$(udisksctl unmount -b "$drive" 2>&1 && udisksctl power-off -b "$drive" 2>&1)"
else
	output="$(udisksctl "$action" -b "$drive" 2>&1)"
fi;

status="$?"

[ -z "$output" && "$status" = 0] && output="OK"

if [ "$status" = 0 ]; then
	notify-send "Udisksctl" "$output"
else
	notify-send "Udisksctl" "$output" -u critical
fi

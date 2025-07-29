#!/bin/bash

ANCHOR=${1:-center}
SELECTION="$(printf "1 - Shutdown\n2 - Reboot\n3 - Reboot to UEFI\n4 - Suspend" | \
fuzzel --dmenu -l 4 -a $ANCHOR --keyboard-focus on-demand)"

case $SELECTION in
	*"Lock")
		swaylock;;
	*"Suspend")
		systemctl suspend;;
	*"Log out")
		swaymsg exit;;
	*"Reboot")
		systemctl reboot;;
	*"Reboot to UEFI")
		systemctl reboot --firmware-setup;;
	*"Hard reboot")
		pkexec "echo b > /proc/sysrq-trigger";;
	*"Shutdown")
		systemctl poweroff;;
esac

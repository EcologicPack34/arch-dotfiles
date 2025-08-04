#!/bin/bash

ANCHOR=${1:-center}
SELECTION="$(printf "1 - Lock\n2 - Shutdown\n3 - Reboot\n4 - Reboot to UEFI\n5 - Suspend\n6 - Log out" | \
fuzzel --dmenu -l 6 -a $ANCHOR --keyboard-focus on-demand)"

case $SELECTION in
	*"Lock")
		hyprlock;;
	*"Suspend")
		systemctl suspend;;
	*"Log out")
		loginctl terminate-user "";;
	*"Reboot")
		systemctl reboot;;
	*"Reboot to UEFI")
		systemctl reboot --firmware-setup;;
	*"Shutdown")
		systemctl poweroff;;
	*"Lock")
		hyprlock;;
esac

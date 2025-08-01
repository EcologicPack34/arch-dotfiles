#!/bin/bash

ANCHOR=${1:-center}
SELECTION="$(printf "1 - Shutdown\n2 - Reboot\n3 - Reboot to UEFI\n4 - Suspend\n5 - Log out" | \
fuzzel --dmenu -l 5 -a $ANCHOR --keyboard-focus on-demand)"

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
esac

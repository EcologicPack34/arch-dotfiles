#!/bin/bash

anchor=${1:-center}
selection="$(printf "1 - Lock\n2 - Shutdown\n3 - Reboot\n4 - Reboot to UEFI\n5 - Suspend\n6 - Log out" | \
fuzzel --dmenu -l 6 -a $anchor --keyboard-focus on-demand)"

case $selection in
	*"Lock")
		hyprlock;;
	*"Suspend")
		systemctl suspend;;
	*"Log out")
		uwsm stop;;
	*"Reboot")
		systemctl reboot;;
	*"Reboot to UEFI")
		systemctl reboot --firmware-setup;;
	*"Shutdown")
		systemctl poweroff;;
	*"Lock")
		hyprlock;;
esac

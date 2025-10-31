#!/bin/bash

# Separate script to restart only the necessary services (add/remove as needed)

systemctl --user restart waybar
pkill -USR1 cava

# For some reason I need to send this to kitty as well when
# cava is running on a terminal since it won't reload the 
# colors automatically.
pkill -USR1 kitty

pywalfox update

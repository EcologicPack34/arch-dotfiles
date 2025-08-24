
#!/bin/sh

resize_size=${1:?Missing resize size}

resize_params_x=0
resize_params_y=0

direction=${2:?Missing move direction}
case $direction in
l)
	resize_params_x=-$resize_size
	;;
r)
	resize_params_x=$resize_size
	;;
u)
	resize_params_y=-$resize_size
	;;
d)
	resize_params_y=$resize_size
	;;
*)
	echo "kbye"
	return 1
	;;
esac

active_window=$(hyprctl activewindow -j)
is_floating=$(echo "$active_window" | jq .floating)

if [ "$is_floating" = "true" ]; then
	hyprctl dispatch moveactive "$resize_params_x" "$resize_params_y"
else
	hyprctl dispatch movewindow "$direction"
fi

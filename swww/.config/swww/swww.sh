wallpaper_dir=~/.cache/wallpaper

swww clear
swww img $wallpaper_dir/current_wallpaper_grayscale --transition-type fade --transition-pos top-right --transition-duration 2 --transition-fps 60
sleep 1
swww img $wallpaper_dir/current_wallpaper  --transition-type grow  --transition-pos top-left --transition-duration 2 --transition-fps 60

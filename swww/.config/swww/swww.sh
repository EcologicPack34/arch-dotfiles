wallpaper_dir=$(xdg-user-dir WALLPAPERS)

swww clear
swww img $wallpaper_dir/frieren_grayscale.jpg --transition-type fade --transition-pos top-right --transition-duration 2 --transition-fps 60
sleep 1
swww img $wallpaper_dir/frieren.jpg  --transition-type grow  --transition-pos top-left --transition-duration 2 --transition-fps 60

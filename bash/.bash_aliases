alias hyprconf='sudo nano ~/.config/hypr/hyprland.conf'
alias bashreload='source ~/.bashrc'
alias please='sudo '
alias kys='systemctl poweroff '
alias NOW=''
alias restart='systemctl reboot '
alias supertree='tree -C -I .git -a'
alias dotfiles='cd ~/dotfiles'

function waifu() {
	kitty icat "$(~/scripts/waifu/waifu.sh "$@")"
	
}

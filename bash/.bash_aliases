alias hyprconf='sudo nano ~/.config/hypr/hyprland.conf'
alias bashreload='source ~/.bashrc'
alias please='sudo '
alias kys='systemctl poweroff '
alias NOW=''
alias restart='systemctl reboot '
alias supertree='tree -C -I .git -a'
alias dotfiles='cd ~/dotfiles'
alias rm='rm -I'

function waifu() {
	FILE="$(~/scripts/waifu/waifu.sh "$@")" || return
	kitty icat "$FILE"
}

function daily_waifu() {
	PROGRAM=("${1:-kitty}") # Use array for programs with args
	[ "${PROGRAM[0]}" = "kitty" ] && PROGRAM=(kitty icat)
	
	WAIFU_FILE="$(~/scripts/waifu/daily-waifu.sh "${@:2}")" || return
	"${PROGRAM[@]}" "$WAIFU_FILE"
}

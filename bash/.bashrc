#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\033[0;32m\u\033[0m@\033[0;36m\h \033[0;33m\W\033[0m]\$ '

alias hyprconfig='nano ~/.config/hypr/hyprland.conf'

alias poff='systemctl poweroff'
alias repoff='systemctl reboot'

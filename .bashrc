#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
#PS1='\[\e[0;38;5;82m\]$ \[\e[0;38;5;45m\]\u \[\e[0;38;5;45m\](\[\e[0;38;5;39m\]\W\[\e[0;38;5;45m\]) \[\e[0;1;38;5;45m\]>\[\e[0m\]'PS1='\[\e[0;2;5;38;5;226m\]$ \[\e[0;2;5;38;5;226m\]\u \[\e[0;2;5;38;5;214m\](\[\e[0;1;5;38;5;226m\]\W\[\e[0;2;5;38;5;214m\]) \[\e[0;1;5;38;5;226m\]>\[\e[0m\]'
PS1='[\[\e[38;5;128;1m\]\u\[\e[0m\]@\[\e[38;5;81;1m\]\h\[\e[0m\](\[\e[38;5;222;1m\]\w\[\e[0m\])]\[\e[38;5;48;1m\]\$\[\e[0m\] '


# If it exists, load the aliases script
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

#fastfetch -c .config/fastfetch/config_short.jsonc

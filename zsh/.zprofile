#####################################################################
# VARS
export EDITOR="vim"
export BROWSER="chromium"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export GREP_COLOR=7 # matches in invert color
export MAKEFLAGS="-j$(getconf _NPROCESSORS_ONLN)"
export TERM="rxvt"
export PAGER="less"
export PATH="$PATH:$HOME/scripts"
export XDG_CONFIG_HOME="$HOME/.config"
export KEYTIMEOUT=1 # faster vim mode switch
export GOPATH="$HOME/prog/go"
export GOMAXPROCS=8
export PATH="$GOPATH/bin:$PATH"
export QT_LOGGING_TO_CONSOLE=1

#export LS_COLORS="no=90:fi=0:di=1;32:ln=1;35:so=1;34:pi=1;34:ex=1;33:bd=1;34:cd=1;34:su=1;34:sg=1;34:tw=1;32:ow=1;32"

#color man
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;35m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;36m'

#gnupginf="$HOME/.gpg-agent-info"
#eval `cat $gnupginf`
#eval `cut -d= -f1 $gnupginf | xargs echo export`

# Start X if log in tty1
if (( UID )); then
	[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi

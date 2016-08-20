#####################################################################
# VARS
export EDITOR="vim"
export BROWSER="chromium"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export GREP_COLOR=7 # matches in invert color
export MAKEFLAGS="-j10"
export TERM="rxvt"
export PAGER="less"
export PATH="$PATH:$HOME/scripts"
export XDG_CONFIG_HOME="$HOME/.config"
export KEYTIMEOUT=1 # faster vim mode switch
export GOPATH="$HOME/prog/go"
export GOMAXPROCS=8
export PATH="$GOPATH/bin:$PATH"
export QT_LOGGING_TO_CONSOLE=1

#color man
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS_TERMCAP_ue=$'\E[0m'

#gnupginf="$HOME/.gpg-agent-info"
#eval `cat $gnupginf`
#eval `cut -d= -f1 $gnupginf | xargs echo export`

# Start X if log in tty1
if (( UID )); then
	[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
fi

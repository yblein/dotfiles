EDITOR="vim"
BROWSER="chromium"
LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
GREP_COLOR=7 # matches in invert color
MAKEFLAGS="-j$(getconf _NPROCESSORS_ONLN)"
PAGER="less"
GOPATH="$HOME/prog/go"
QT_LOGGING_TO_CONSOLE=1

typeset -U path # remove duplicates in path
path+=(
	$HOME/.cargo/bin
	$GOPATH/bin
	$HOME/bin
)

#color man
LESS_TERMCAP_mb=$'\e[01;31m'
LESS_TERMCAP_md=$'\e[01;35m'
LESS_TERMCAP_me=$'\e[0m'
LESS_TERMCAP_se=$'\e[0m'
LESS_TERMCAP_so=$'\e[01;33m'
LESS_TERMCAP_ue=$'\e[0m'
LESS_TERMCAP_us=$'\e[01;36m'

#eval $(keychain -q --nogui --noask --eval ~/.ssh/id_rsa)

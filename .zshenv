export EDITOR="vim"
export BROWSER="chromium"
export LANG="en_US.UTF-8"
export GREP_COLOR=7 # matches in invert color
export MAKEFLAGS="-j$(getconf _NPROCESSORS_ONLN)"
export PAGER="less"
export GOPATH="$HOME/prog/go"
export SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS=0

# fzf settings
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

typeset -U path # remove duplicates in path
path+=(
	$HOME/.cargo/bin
	$GOPATH/bin
	$HOME/bin
	$HOME/.local/bin
)

#color man
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;35m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;36m'

#eval $(keychain -q --nogui --noask --eval ~/.ssh/id_rsa)

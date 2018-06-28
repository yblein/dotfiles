# fish config
set -x fish_greeting

function autols --on-event fish_preexec
	if test -z $argv
		eval ls
	end
end

function newline --on-event fish_postexec
	set ret $status
	if test $ret -ne 0
		echo -s "→ " (set_color red) $ret (set_color normal)
	end
	printf "\n"
end

# aliases
abbr l 'ls -lh'
abbr ll 'ls -lha'
abbr k killall
abbr v vim
abbr sv 'sudo vim'
abbr spm "sudo pacman"
abbr s 'pacaur -S'
abbr r 'sudo pacman -Rsn'
abbr u 'sudo pacman -Syu'
abbr i 'pacman -Qi'
abbr k 'killall'
abbr c 'cat'
abbr z 'zathura'
abbr g 'git'
abbr px 'chmod +x'
abbr m 'make'
abbr t 'st&'
abbr diff 'colordiff'
abbr rr 'rm -r'
abbr x 'sxiv'

# vars
set -x EDITOR "vim"
set -x BROWSER "chromium"
set -x PAGER "less"
set -x LANG "en_US.UTF-8"
set -x LC_ALL "en_US.UTF-8"
set -x GREP_COLOR 7 # matches in invert color
set -x MAKEFLAGS "-j9"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x QT_LOGGING_TO_CONSOLE 1
set -x SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS 0
set -x GOMAXPROCS 8
set -x GOPATH "$HOME/prog/go"
set -x PATH $HOME/.cargo/bin $GOPATH/bin $HOME/scripts $PATH

# color man
set -x LESS_TERMCAP_mb (printf '\e[01;31m')
set -x LESS_TERMCAP_md (printf '\e[01;35m')
set -x LESS_TERMCAP_me (printf '\e[0m')
set -x LESS_TERMCAP_se (printf '\e[0m')
set -x LESS_TERMCAP_so (printf '\e[01;33m')
set -x LESS_TERMCAP_ue (printf '\e[0m')
set -x LESS_TERMCAP_us (printf '\e[01;36m')

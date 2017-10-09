#####################################################################
# LOAD
autoload -U zmv
autoload history-search-end
# autoload -U url-quote-magic
# zle -N self-insert url-quote-magic
autoload -U compinit && compinit
autoload -U colors
autoload -U edit-command-line
zle -N edit-command-line
zmodload -i zsh/complist
zmodload -i zsh/mathfunc
zmodload -a zsh/stat stat # stat file
#zmodload -a zsh/zprof zprof # profile sh functions
autoload -U insert-files && zle -N insert-files
autoload -U predict-on
zle -N predict-on predict-off #&& predict-on

#####################################################################
# VARS
HISTFILE="$HOME/.history"
HISTSIZE=8192
SAVEHIST=8192
REPORTTIME=1

colors
eval "`dircolors`"

#####################################################################
# KEYBINDINGS
bindkey -v
bindkey "^f" insert-files
# edit command line
bindkey -M vicmd 'v' edit-command-line
# vimrc-like
bindkey -M vicmd 'H' vi-beginning-of-line
bindkey -M vicmd 'L' vi-end-of-line
# vim-like completion
bindkey "^p" up-line-or-search
bindkey "^n" down-line-or-search
# backward search
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
# arrows
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
# readline-like
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^d' delete-char
# del
bindkey -M viins '^[[3~' delete-char
bindkey -M vicmd '^[[3~' delete-char
# home/end for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# accept current completion
bindkey -M menuselect '/' accept-and-infer-next-history

#####################################################################
# PROMPT(s)
PROMPT="%{$fg[red]%}%(?..[%?]) %{$fg[magenta]%}%30<..<%~%{$fg[yellow]%} %(!.#.>)%{$reset_color%} "
SPROMPT="zsh: correct '$fg[red]%R$reset_color' to '$fg[green]%r$reset_color' [nyae]? "

#####################################################################
# OPTIONS
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_store
setopt auto_cd
setopt extended_glob
setopt complete_in_word
setopt notify
setopt no_hup
setopt no_beep
setopt numeric_glob_sort
setopt multios
setopt csh_junkie_history
setopt ksh_option_print
setopt bsd_echo
setopt always_last_prompt
setopt auto_pushd
setopt auto_name_dirs
setopt cdable_vars
setopt hist_find_no_dups
setopt auto_list
setopt no_list_ambiguous # complete as far as possible
setopt correct
#setopt correct_all

#####################################################################
# PREDICTION
#zstyle :predict verbose yes
#zstyle :predict cursor key
#zstyle ':completion:predict:*' completer \
#	_oldlist _complete _ignored _history _prefix
#zstyle :predict toggle yes

#####################################################################
# FUNCTIONS
#function s () { yaourt -S "$@" && rehash; }
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
function bak () { cp -r "$1" "$1.bak" }
function sdm() { udisksctl mount -b "/dev/sd$1" }
function sdu() { udisksctl unmount -b "/dev/sd$1" }
function twitch() { mpv --ytdl-format "[tbr<2000]" "http://www.twitch.tv/$1" }
function y() {
	pacaur -S $(pacaur --color=always -Ss $@ | sed '$!N;s/\n    / /' | fzf --ansi -m | cut -d " " -f 1)
}

#####################################################################
# TERMINAL TITLE (for X terminals)
precmd () { print -Pn "\e]0;%~ %(!.#.>)\a" }
preexec () { print -Pn "\e]0;%~ %(!.#.>) $1\a" }

#####################################################################
# ALIASES
alias ls='ls --color=auto -F'
alias l='ls -lh'
alias ll='l -a'
alias grep='grep --color=auto'
alias v='vim'
alias vi='vim'
alias sv='sudo vim'
alias spm="sudo pacman"
alias s='pacaur -S'
alias r='sudo pacman -Rsn'
alias u='sudo pacman -Syu'
alias i='pacman -Qi'
alias k='killall'
alias c='cat'
alias px='chmod +x'
alias z='zathura'
alias p='mplayer -idx'
alias g='git'
alias m='make'
alias t='st&'
alias diff='colordiff'
alias rr='rm -r'
alias x='sxiv'
alias path='echo -e ${PATH//:/\\n}'

#####################################################################
# AUTO LS
auto-ls () {
	#echo $WIDGET
	#if [[ -f $BUFFER ]]; then
		#cat $BUFFER
	#fi
    if [[ $#BUFFER -eq 0 ]]; then
        echo ""
        ls
        zle redisplay
    else
        zle .$WIDGET
    fi
}
zle -N accept-line auto-ls
zle -N other-widget auto-ls

#####################################################################
# COMPLETION (derived from grml)

zstyle ':completion:*'                 menu select

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

# don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*'       insert-unambiguous true
zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:correct:*'       original true

# activate color-completion
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

# format on completion
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*'        tag-order all-expansions
zstyle ':completion:*:history-words'   list false

# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# match uppercase from lowercase
zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

# separate matches into groups
zstyle ':completion:*:matches'         group 'yes'
zstyle ':completion:*'                 group-name ''

zstyle ':completion:*:messages'        format '%d'
zstyle ':completion:*:options'         auto-description '%d'

# describe options in full
zstyle ':completion:*:options'         description 'yes'

# on processes completion complete all user processes
zstyle ':completion:*:processes'       command 'ps -au$USER'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# provide verbose completion information
zstyle ':completion:*'                 verbose true

# recent (as of Dec 2007) zsh versions are able to provide descriptions
# for commands (read: 1st word in the line) that it will list for the user
# to choose from. The following disables that, because it's not exactly fast.
zstyle ':completion:*:-command-:*:'    verbose false

# set format for warnings
zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
#zstyle ':completion:correct:'          prompt 'correct to: %e'

# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true

# provide .. as a completion
zstyle ':completion:*' special-dirs ..

# run rehash on completion so new installed program are found automatically:
function _force_rehash () {
    (( CURRENT == 1 )) && rehash
    return 1
}

## correction
# try to be smart about when to use what completer...
zstyle -e ':completion:*' completer '
    if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
        _last_try="$HISTNO$BUFFER$CURSOR"
        reply=(_complete _match _ignored _prefix _files)
    else
        if [[ $words[1] == (rm|mv) ]] ; then
            reply=(_complete _files)
        else
            reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
        fi
    fi'

# command for process lists, the local web server details and host completion
zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'

# Some functions, like _apt and _dpkg, are very slow. We can use a cache in
# order to speed things up
zstyle ':completion:*' use-cache  yes
zstyle ':completion:*:complete:*' cache-path "$USER/.cache/zsh"

# host completion
[[ -r ~/.ssh/config ]] && _ssh_config_hosts=(${${(s: :)${(ps:\t:)${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }}}:#*[*?]*}) || _ssh_config_hosts=()
[[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
    $(hostname)
    "$_ssh_config_hosts[@]"
    "$_ssh_hosts[@]"
    "$_etc_hosts[@]"
    localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# syntax
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

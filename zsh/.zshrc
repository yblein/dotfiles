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
bindkey -M menuselect '^m' accept-line

#####################################################################
# PROMPT(s)
PROMPT="%{$fg[red]%}%(?..[%?]) %{$fg[magenta]%}%30<..<%~%{$fg[yellow]%} %(!.#.>)%{$reset_color%} "
SPROMPT="zsh: correct '$fg[red]%R$reset_color' to '$fg[green]%r$reset_color' [nyae]? "

#####################################################################
# OPTIONS
umask 022
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

#####################################################################
# TERMINAL TITLE (for X terminals)
precmd () { print -Pn "\e]0;[%n@%M][%~]%#\a" }
preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }

#####################################################################
# ALIASES
alias ls='ls --color=auto -F'
alias l='ls -lh'
alias ll='l -a'
alias ukill='pkill -KILL -u'
alias ..='cd ..'
alias grep='grep --color=auto'
alias gr='grep -nr'
alias v='vim'
alias vi='vim'
alias sv='sudo vim'
alias spm="sudo pacman"
alias y='yaourt'
alias s='yaourt -S'
alias r='sudo pacman -Rsn'
alias u='sudo pacman -Syu'
alias i='pacman -Qi'
alias k='killall'
alias c='cat'
#alias rm='rm -v'
alias cp='cp -i'
alias px='chmod +x'
alias z='zathura'
alias p='mplayer -idx'
alias g='git'
alias m='make'
alias t='st&'
alias diff='colordiff'
alias rr='rm -r'
alias x='sxiv'

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
# COMPLETION (from grml)
## completion system
  zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )' # allow one error for every three characters typed in approximate completer
  zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # don't complete backup files as executables
  zstyle ':completion:*:correct:*'       insert-unambiguous true             # start menu completion only if it could find no unambiguous initial string
  zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}' #
  zstyle ':completion:*:correct:*'       original true                       #
  zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}      # activate color-completion(!)
  zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'  # format on completion
  zstyle ':completion:*:*:cd:*:directory-stack' menu yes select              # complete 'cd -<tab>' with menu
  zstyle ':completion:*:expand:*'        tag-order all-expansions            # insert all expansions for expand completer
  zstyle ':completion:*:history-words'   list false                          #
  zstyle ':completion:*:history-words'   menu yes                            # activate menu
  zstyle ':completion:*:history-words'   remove-all-dups yes                 # ignore duplicate entries
  zstyle ':completion:*:history-words'   stop yes                            #
  zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'        # match uppercase from lowercase
  zstyle ':completion:*:matches'         group 'yes'                         # separate matches into groups
  zstyle ':completion:*'                 group-name ''
  if [[ -z "$NOMENU" ]] ; then
    zstyle ':completion:*'               menu select=5                       # if there are more than 5 options allow selecting from a menu
  else
    setopt no_auto_menu # don't use any menus at all
  fi
  zstyle ':completion:*:messages'        format '%d'                         #
  zstyle ':completion:*:options'         auto-description '%d'               #
  zstyle ':completion:*:options'         description 'yes'                   # describe options in full
  zstyle ':completion:*:processes'       command 'ps -au$USER'               # on processes completion complete all user processes
  zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters        # offer indexes before parameters in subscripts
  zstyle ':completion:*'                 verbose true                        # provide verbose completion information
  zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d' # set format for warnings
  zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'       # define files to ignore for zcompile
  zstyle ':completion:correct:'          prompt 'correct to: %e'             #
  zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'    # Ignore completion functions for commands you don't have:

# complete manual by their section
  zstyle ':completion:*:manuals'    separate-sections true
  zstyle ':completion:*:manuals.*'  insert-sections   true
  zstyle ':completion:*:man:*'      menu yes select

## correction
# run rehash on completion so new installed program are found automatically:
  _force_rehash() {
      (( CURRENT == 1 )) && rehash
         return 1 # Because we didn't really complete anything
    }
# some people don't like the automatic correction - so run 'NOCOR=1 zsh' to deactivate it
  if [[ -n "$NOCOR" ]] ; then
    zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files
    setopt nocorrect # do not try to correct the spelling if possible
  else
#    zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _correct _approximate _files
    setopt correct  # try to correct the spelling if possible
    zstyle -e ':completion:*' completer '
        if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]]; then
          _last_try="$HISTNO$BUFFER$CURSOR"
          reply=(_complete _match _prefix _files)
        else
          if [[ $words[1] = (rm|mv) ]]; then
            reply=(_complete _files)
          else
            reply=(_oldlist _expand _force_rehash _complete _correct _approximate _files)
          fi
        fi'
  fi
# zstyle ':completion:*' completer _complete _correct _approximate
# zstyle ':completion:*' expand prefix suffix

# automatic rehash? Credits go to Frank Terbeck
# function my_accept () {
#   local buf
#   [[ -z ${BUFFER} ]] && zle accept-line && return
#   buf=( ${(z)BUFFER}  )
#   [[ -z ${commands[${buf[1]}]} ]] && rehash
#   zle accept-line
# }
# zle -N my_accept
# bindkey "^M" my_accept

# command for process lists, the local web server details and host completion
  zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'
  
  # caching
  zstyle ':completion:*' use-cache yes
  zstyle ':completion::complete:*' cache-path $HOME/cache/zsh

# host completion /* add brackets as vim can't parse zsh's complex cmdlines 8-) {{{ */
    [ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
    [ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
  hosts=(
      `hostname`
      "$_ssh_hosts[@]"
      "$_etc_hosts[@]"
      grml.org
      localhost
  )
  zstyle ':completion:*:hosts' hosts $hosts
#  zstyle '*' hosts $hosts

# pretty kill completion. colored, cpu load & process tree
zstyle ':completion:*:kill:*' command 'ps xf -u $USER -o pid,%cpu,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select

# syntax
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

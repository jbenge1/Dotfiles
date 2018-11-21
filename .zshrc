##If not running interactively, do not do anything
#[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmuxinator default
autoload -U colors && colors
## Prompt

## Basic Prompt
#PS1="[%n@%M %1~]$ "

## More advanced prompt
LPROMPT () {
PS1="┌─[%{$fg[cyan]%}%m%{$fg_bold[blue]%} %1~%{$fg_no_bold[yellow]%}%(0?.. %?)%{$reset_color%}]
└─╼ "
}

LPROMPT
PROMPT_EOL_MARK=" •"
#History stuff
HISTFILE=~/.histfile
HISTSIZE=1500
SAVEHIST=3000
HISTORY_IGNORE="(ls|history|cd|clear|lls)"


#EDITOR=vim
#export EDITOR

#Dircolors
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#Options set by me
setopt appendhistory autocd extendedglob nomatch notify COMPLETE_ALIASES
bindkey -v

# Correct my mistakes
setopt correct

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

## This reverts the +/- operators.
#setopt PUSHD_MINUS

#add `|' to output redirections in the history
setopt histallowclobber

## try to avoid the 'zsh: no matches found...'
setopt nonomatch

## warning if file exists ('cat /dev/null > ~/.zshrc')
setopt clobber

## don't warn me about bg processes when exiting
setopt nocheckjobs

## alert me if something failed
#setopt printexitvalue

## with spelling correction, assume dvorak kb
#setopt dvorak

## Allow comments even in interactive shells
#setopt interactivecomments

#zstyle :compinstall filename '/home/justin/.zshrc'

## Hopefully home and end keys will work now
#bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

##Alias'
## (These are mine)
alias ls="ls --color -F"
alias lls='ls -lAh'
alias mv='mv -v'
alias grep='grep --color=auto'
alias batteryPerc='cat /sys/class/power_supply/BAT0/capacity'
alias cpu_raper='for i in 1 2 3 4; do while : ; do : ; done & done'
alias torchroot='sudo chroot --userspec=tor:tor /opt/torchroot /usr/bin/tor'
alias pacinfo="pacman -Qi"
alias tmux='tmuxinator default'
alias browser='tor-browser'
alias paste-bin="| curl -F c=@- https://ptpb.pw "
alias :q="exit"
## global aliases (for those who like them) ##

alias -g '...'='../..'
alias -g '....'='../../..'
alias -g BG='& exit'
alias -g C='|wc -l'
alias -g G='|grep'
alias -g H='|head'
alias -g Hl=' --help |& less -r'
alias -g K='|keep'
alias -g L='|less'
alias -g LL='|& less -r'
alias -g M='|most'
alias -g N='&>/dev/null'
alias -g R='| tr A-z N-za-m'
alias -g SL='| sort | less'
alias -g S='| sort'
alias -g T='|tail'
alias -g V='| vim -'
alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -o "PreferredAuthentications=keyboard-interactive"'

autoload -Uz compinit
compinit

# Remember the dir staack
#DIRSTACKFILE="$HOME/.cache/zsh/dirs"
#if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
#  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
#  [[ -d $dirstack[1] ]] && cd $dirstack[1]
#fi
# chpwd() {
#  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
#}

#DIRSTACKSIZE=20

## ignore ~/.ssh/known_hosts entries


#$abk[SnL]="| sort -n | less"

## get top 10 shell commands:
alias top10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

## Memory overview
memusage() {
    ps aux | awk '{if (NR > 1) print $5;
                   if (NR > 2) print "+"}
                   END { print "p" }' | dc
}

## print hex value of a number
hex() {
    emulate -L zsh
    if [[ -n "$1" ]]; then
        printf "%x\n" $1
    else
        print 'Usage: hex <number-to-convert>'
        return 1
    fi
}


#Miscellaneous options
cd
#Enable backwards search
bindkey -v
bindkey '^R' history-incremental-search-backward
source /usr/share/doc/pkgfile/command-not-found.zsh
# End of lines added by compinstall


##NOW a bunch of other options :)
#zle -N predict-on  && \
#zle -N predict-off && \
#bindkey "^Z" predict-on && \
#bindkey "^Z^X" predict-off
#autoload -Uz run-help
#unalias run-help
#alias help=run-help
cat /home/justin/TODO.txt

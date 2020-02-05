##It's time to ditch grml (not that they're bad or anything,
# in fact I really enjoyed their zsh config). But this 
# is my zshrc built from the ground up (I actually
# know what it is doing)
autoload -U colors && colors

#### VARIABLES ####
export EDITOR=vim
export BROWSER=firefox


#### PROMPTS ####
## Basic prompt
#PS1="[%n@%m %1~]$ "

## Advanced prompt (this is a left side prompt)
PROMPT="[%{$fg[cyan]%}%m%{$fg_bold[blue]%} %1~%{$fg_no_bold[yellow]%}%(0?.. %?)%{$reset_color%}]$ "
## this is a right side prompt
RPROMPT="%B%F{yellow}%(0?.. :()%f%b"

## History stuff
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=6000
HISTORY_IGNORE="ls|history|cd|clear|lls)"

## For Directory coloring
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

## For man page coloring
#export PAGER="most" #(maybe there is a better way?)

#### OPTIONS ####
## Don't replace the history file
setopt appendhistory
## cd into dir by typing name of dir
setopt autocd 
## Treat '#'... as part of patterns for filenames
setopt extendedglob 
## Print error for filename generation wth no match
setopt nomatch 
## Immeditaly tell us the status of bg jobs
setopt notify 
## Alias is a distinct command for completion purposes
setopt complete_aliases
## Fix my typos
setopt correct
## Automatically push the old dir onto the stack
setopt auto_pushd
## pushd with no arguments is pushd $HOME
setopt pushd_to_home
## Don't push duplicates to dir stack
setopt pushd_ignore_dups
## add '|' to output redirections in history
setopt hist_allow_clobber
## Not entirly sure
#setopt nomatch
## clobber the old file 'cat /dev/null > ~/.zshrc
setopt clobber
## Dont warn me about bg process when exiting
setopt nocheckjobs

#### ALIAS' ####
alias ls="ls --color -F"
alias lls='ls -lAh'
alias mv='mv -v'
alias grep='grep --color=always'
alias batteryPerc='cat /sys/class/power_supply/BAT0/capacity'
alias cpu_raper='for i in 1 2 3 4; do while : ; do : ; done & done'
alias torchroot='sudo chroot --userspec=tor:tor /opt/torchroot /usr/bin/tor'
alias pacinfo="pacman -Qi"
alias tmux='tmuxinator default'
alias browser='tor-browser'
alias paste-bin="$1 | curl -F c=@- https://ptpb.pw "
alias :q="exit"
alias u='translate -i'
alias mpv='mpv -fs'
alias docker_ip='docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $1'
alias fun="repo-elephant | lolcat"
alias quote="fortune | cowsay | lolcat"
#alias sl="sl | lolcat"
#I'm sick of accidentally typing too fast and opening in vi >:( 
alias vi="vim"
alias clear="clear && archfetch"
alias py='python'
#alias grep="echo use sed isntead :p"

#GIT Alias'
alias reflog='git reflog'
alias branch='git checkout -b'
alias glog='git log'
alias rebase='git rebase -i HEAD~'
#
## Global alias'
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
## Get top 10 shell commands
alias top10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'


### FUNCTIONS ####
## Clear function 

clearFunct() {
    NUM=0

    if [[ num -eq 0  ]]; then
        clear && archfetch
    elif [[ num -eq 1 ]]; then
        clear && fortune | cowsay | lolcat
    else
        clear && repo-elephant | lolcat
    fi
}
## Memory overview
memusage() {
    ps aux | awk '{if (NR > 1) print $5;
                   if (NR > 2) print "+"}
                   END { print "p" }' | dc
}

## print hex value of a number
function hex() {
    emulate -L zsh
    if [[ -n "$1" ]]; then
        printf "%x\n" $1
    else
        print 'Usage: hex <number-to-convert>'
        return 1
    fi
}

# smart cd function, allows switching to /etc when running 'cd /etc/fstab'
function cd () {
    if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
        [[ ! -e ${1:h} ]] && return 1
        print "Correcting ${1} to ${1:h}"
        builtin cd ${1:h}
    else
        builtin cd "$@"
    fi
}

# Create Directory and \kbd{cd} to it
function mkcd () {
    if (( ARGC != 1 )); then
        printf 'usage: mkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1"
}

# Create temporary directory and \kbd{cd} to it
function cdt () {
    builtin cd "$(mktemp -d)"
    builtin pwd
}

# List files which have been accessed within the last {\it n} days, {\it n} defaults to 1
function accessed () {
    emulate -L zsh
    print -l -- *(a-${1:-1})
}

# List files which have been changed within the last {\it n} days, {\it n} defaults to 1
function changed () {
    emulate -L zsh
    print -l -- *(c-${1:-1})
}

# run command line as user root via sudo:
function sudo-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}

### jump behind the first word on the cmdline.
### useful to add options.
function jump_after_first_word () {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[1]}}
    fi
}
### WIDGET MANAGEMENT ###
#Enable backwards search
bindkey -v
bindkey '^R' history-incremental-search-backward
source /usr/share/doc/pkgfile/command-not-found.zsh

#bindkey "${terminfo[khome]}" beginning-of-line
#bindkey "${terminfo[kend]}" end-of-line


zle -N sudo-command-line

zle -N jump_after_first_word

bindkey "^os" sudo-command-line
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^xf"  jump_after_first_word

### MISC ###
## reports what repo a command is from if not installed
source /usr/share/doc/pkgfile/command-not-found.zsh
## For better completion
autoload -Uz compinit
compinit
## allow a menu and use arrow keys :)
zstyle ':completion:*' menu select
## allow sudo completion
zstyle ':completion::complete:*' gain-privileges 1

## Source external functions
source ~/.external_functions
#### TEMPORARY DELTE WHEN DONE ####
source /home/justin/getToken
####
#Acurl wttr.in
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

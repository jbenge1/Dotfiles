#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#ALIAS'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fprocess='ps aux | grep'
alias lls='ls -lAh'
alias diff='diff --color=auto'
alias mv='mv -v'
alias batteryPerc='cat /sys/class/power_supply/BAT0/capacity'
alias cpu_raper='for i in 1 2 3 4; do while : ; do : ; done & done'
alias torchroot='sudo chroot --userspec=tor:tor /opt/torchroot /usr/bin/tor'

#GIT Alias'
alias reflog='git reflog'
alias branch='git checkout -b'
alias glog='git log'
alias rebase='git rebase -i HEAD~'
#
PS1='[\u@\h \W]\$ '

HISTSIZE=1500
HISTIGNORE=ls:history:cd:clear:lls

#Enter a dirname to cd into it
shopt -s autocd

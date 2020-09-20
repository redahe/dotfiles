# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return
set -o vi

export PS1="\[\e]0;\w\a\]\n\[\e[1;36m\]\u@\h \[\e[0;36m\]\w\[\e[0m\]\n\$ "
export NNTPSERVER='news.eternal-september.org'
export EDITOR=vim
export PATH="~/bin:$PATH"

eval `dircolors ~/.dircolors`

alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias ls='ls --color=auto'
alias diff='colordiff'
alias tmux='tmux -2'
alias slrn='LANG=en_US.UTF-8 slrn'
alias slrnpull='LANG=en_US.UTF-8 slrnpull'

#--LOCAL SPECIFIC--
if [ -f "${HOME}/.bash_localrc" ] ; then
  source "${HOME}/.bash_localrc"
fi



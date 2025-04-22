PROMPT="%B%F{45}%n %~%b%# %f"
setopt correct
autoload -U compinit; compinit
zstyle ':completion:*' menu select
bindkey -v


export EDITOR=nvim
export PATH="$HOME/bin:$PATH"

eval `dircolors ~/.dircolors`

alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias ls='ls --color=auto'
alias diff='colordiff'
alias tmux='tmux -2'
alias slrn='LANG=en_US.UTF-8 slrn'
alias slrnpull='LANG=en_US.UTF-8 slrnpull'

alias vi=nvim

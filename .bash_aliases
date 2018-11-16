alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias 2..=...
alias 3..=....
alias 4..=.....

alias ll='ls -l'
alias la='ls -A'
alias lla='ls -la'

alias vi='vim'
alias vix='vi -c \"Vex\"'

alias :q='exit'
alias :wq='exit'

alias po='pdfopen'
alias pdfopen='pdfopen --viewer evince'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep -n --color=auto'
    alias fgrep='fgrep -n --color=auto'
    alias egrep='egrep -n --color=auto'
fi

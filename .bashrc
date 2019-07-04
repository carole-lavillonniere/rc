# [[ $TERM != "screen" ]] && exec tmux

export LANG=en_US.UTF-8

eval "$(direnv hook bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export HISTSIZE=10000
export HISTFILESIZE=10000
export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

# Zsh-like autocompletion
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# History complete what's already on the line
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

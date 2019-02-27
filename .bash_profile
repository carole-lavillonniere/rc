source ~/.env
source ~/.bashrc
source ~/.profile
eval "$(rbenv init -)"
export GOPATH=$HOME/go-home
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/kibana@5.6/bin:$PATH"
export PATH="/Users/carolelavillonniere/Documents/idagio/fff:$PATH"

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='\[\033[0;36m\]\w\[\033[0;32m\] - ($(git branch 2>/dev/null | grep "^*" | colrm 1 2)) \[\033[0m\033[0;32m\]\[\033[0m\]'

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
# added by Anaconda3 5.3.0 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

if [ -e .nvmrc ]; then
  nvm use
fi


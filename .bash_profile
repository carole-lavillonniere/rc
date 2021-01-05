source ~/.env
source ~/.bashrc
source ~/.profile
eval "$(rbenv init -)"
export GOPATH=$HOME/go-home
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/kibana@5.6/bin:$PATH"
export PATH="/Users/carolelavillonniere/Documents/idagio/fff:$PATH"

export PS1='\[\033[0;36m\]\w\[\033[0;32m\] - ($(git branch 2>/dev/null | grep "^*" | colrm 1 2)) \[\033[0m\033[0;32m\]\[\033[0m\]'

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'


is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-git-status() {
  is_in_git_repo || return
  s | fzf-tmux | awk  '{print $2}'
}
bind '"\C-f": "$(fzf-git-status)\e\C-e\er"'

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

# Setup for Postgresql@10
export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
export PGHOST=localhost
export LDFLAGS="-L/usr/local/opt/postgresql@10/lib"
export CPPFLAGS="-I/usr/local/opt/postgresql@10/include"
export PKG_CONFIG_PATH="/usr/local/opt/postgresql@10/lib/pkgconfig"

# Bash Git completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

complete -C /usr/local/bin/packer packer

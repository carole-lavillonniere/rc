# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite itfter each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# battery status
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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

# Automatically call nvm use
find-up () {
    path=$(pwd)
    while [[ "$path" != "" && ! -e "$path/$1" ]]; do
        path=${path%/*}
    done
    echo "$path"
}

cdnvm(){
    cd "$@";
    nvm_path=$(find-up .nvmrc | tr -d '[:space:]')

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

        declare default_version;
        default_version=$(nvm version default);

        # If there is no default version, set it to `node`
        # This will use the latest version on your machine
        if [[ $default_version == "N/A" ]]; then
            nvm alias default node;
            default_version=$(nvm version default);
        fi

        # If the current version is not the default version, set it to use the default version
        if [[ $(nvm current) != "$default_version" ]]; then
            nvm use default;
        fi

        elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
        declare nvm_version
        nvm_version=$(<"$nvm_path"/.nvmrc)

        declare locally_resolved_nvm_version
        # `nvm ls` will check all locally-available versions
        # If there are multiple matching versions, take the latest one
        # Remove the `->` and `*` characters and spaces
        # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
        locally_resolved_nvm_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

        # If it is not already installed, install it
        # `nvm install` will implicitly use the newly-installed version
        if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
            nvm install "$nvm_version";
        elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
            nvm use "$nvm_version";
        fi
    fi
}

complete -C /usr/local/bin/terraform terraform

eval "$(rbenv init -)"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH="/usr/local/opt/kibana@5.6/bin:$PATH"
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:/usr/pgadmin4/bin
export PATH=$PATH:$HOME/.local/bin
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

alias fzf-git-status="s | fzf-tmux | cut -d' ' -f3"
bind '"\C-f": "$(fzf-git-status)\e\C-e"'

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
export PATH="$HOME/sumup/dsf-debian/:$PATH"
export PGHOST=localhost
export LDFLAGS="-L/usr/local/opt/postgresql@10/lib"
export CPPFLAGS="-I/usr/local/opt/postgresql@10/include"
export PKG_CONFIG_PATH="/usr/local/opt/postgresql@10/lib/pkgconfig"

# Bash Git completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

complete -C /usr/local/bin/packer packer
source <(kubectl completion bash)

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

alias ll="ls -lahL"
alias ls="ls -G -a -1"
alias s='git status -s'
alias c='git commit'
alias gcp='git cherry-pick'
alias gr='git rebase'
alias grm='git rebase master'
alias gri='git rebase -i'
alias gra='git rebase --abort'
alias grs='git rebase --skip'
alias grc='git rebase --continue'
alias gsa='git stash --include-untracked'
alias gsu='git stash save --keep-index'
alias gsp='git stash pop'
alias gpf='git push -f'
alias gmt='git mergetool'
alias jvim='jq . | vim +"set ft=json"'
alias lg='git lg'
alias lgraph='git log --graph --pretty'
alias gfiles='git show --pretty="format:" --name-only'
alias ag='ag --path-to-ignore ~/.gitignore_global --hidden --ignore-dir .git'
alias uuidgen='uuidgen | tr "[:upper:]" "[:lower:]"'
alias publickeycopy='cat ~/.ssh/id_rsa.pub | pbcopy'
alias cat='batcat'
alias gpr='hub pull-request'
alias timeout='gtimeout'
alias edkibana='sudo vim ~/Applications/kibana-5.6.9-darwin-x86_64/config/kibana.yml'
alias restartelastic='sudo systemctl restart elasticsearch.service'
alias restartkibana='sudo systemctl restart kibana.service'
alias vimkibana='sudo vim /etc/kibana/kibana.yml'
alias elasticlogspath='echo /var/log/elasticsearch/ && sudo ls /var/log/elasticsearch/'
alias lgme='git lg -500 | egrep " [Cc]arole[-_ ][Ll]avillonniere\)"'
alias cdrc='cd $HOME/Workspaces/rc'
alias killbuild='lsof -i :3000 | grep node | head -n 1 | awk "{print \$2}" | xargs kill -9'
alias wgup='sudo wg-quick up wg0'
alias netstat8080="sudo netstat -ltnp | grep -w ':8080'"

# Limitations:
# - Only the default branch is considered (usually master)
alias lastweek="date -u --date='7 days ago' +%Y-%m-%d | xargs -I {} curl -u $GITHUB_USERNAME:$GITHUB_API_TOKEN -H 'Accept: application/vnd.github.cloak-preview' \"https://api.github.com/search/commits?q=author:$GITHUB_USERNAME+committer-date:>{}&sort=committer-date&order=desc\" | jq '.items[] | {url: .html_url, message: .commit.message}'"

alias k='kubectl'
complete -F __start_kubectl k
alias kgp='kubectl get pods'
alias kdp='kubectl describe pod'
alias kl='kubectl logs'
alias kgn='kubectl get namespaces'
alias kgd='kubectl get deployments'
alias ksd='kubectl scale deployment'
alias kex='kubectl exec  -it'

alias getpods-sse='kubectl --kubeconfig ~/.kube/config.yaml -n sse get pods'
alias screenshot='flameshot gui'
source ~/.env

git config --global url."https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/".insteadOf "https://github.com/"

# Starship shell prompt
eval "$(starship init bash)"

# Add fonts
xset +fp /home/carolavillo/.fonts
xset fp rehash

[[ -s "/home/carolavillo/.gvm/scripts/gvm" ]] && source "/home/carolavillo/.gvm/scripts/gvm"

. "$HOME/.cargo/env"

# make aws-vault execute ykman to generate tokens
# https://github.com/99designs/aws-vault/blob/90c6834e431769acbeb13223dcae996923b8820e/USAGE.md#usage-1
export AWS_VAULT_PROMPT=ykman

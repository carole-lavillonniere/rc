alias ll="ls -lahL"
alias ls="ls -G -a -1"
alias date="gdate"
alias s='git status -s'
alias c='git commit '
alias jvim='jq . | vim +"set ft=json"'
alias lg='git lg'
alias gfiles='git show --pretty="format:" --name-only'
alias ag='ag --path-to-ignore ~/.gitignore_global'
alias uuidgen='uuidgen | tr "[:upper:]" "[:lower:]"'
alias publickeycopy='cat ~/.ssh/id_rsa.pub | pbcopy'
alias cat='bat'
alias gpr='hub pull-request'
alias timeout='gtimeout'
alias date='gdate'
alias edkibana='sudo vim ~/Applications/kibana-5.6.9-darwin-x86_64/config/kibana.yml'
alias restartkibana='brew services restart kibana@5.6'
alias restartelasticsearch='brew services restart elasticsearch@5.6'
alias lgme='git lg -500 | egrep " [Cc]arole[-_ ][Ll]avillonniere\)"'
alias ctags="`brew --prefix`/bin/ctags -R --exclude=.git --exclude=node_modules --exclude=.meteor"
alias cdrc='cd $HOME/Documents/Workspaces/rc'

# Limitations:
# - Only the default branch is considered (usually master)
alias lastweek="date -u --date='7 days ago' +%Y-%m-%d | xargs -I {} curl -u $GITHUB_USERNAME:$GITHUB_API_TOKEN -H 'Accept: application/vnd.github.cloak-preview' \"https://api.github.com/search/commits?q=author:$GITHUB_USERNAME+committer-date:>{}&sort=committer-date&order=desc\" | jq '.items[] | {url: .html_url, message: .commit.message}'"

[[ -s "/Users/carolelavillonniere/.gvm/scripts/gvm" ]] && source "/Users/carolelavillonniere/.gvm/scripts/gvm"

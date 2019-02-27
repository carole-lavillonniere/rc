alias ll="ls -lahL"
alias ls="ls -G -a"
alias date="gdate"
alias s='git status '
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
alias cdsearch='cd ~/go-home/src/github.com/idagio/idagio-search-service'
alias cdetl='cd ~/Documents/idagio/idagio-metadata-etl'
alias cdgo='cd ~/go-home/src/github.com/idagio'  
alias cddiscover='cd ~/go-home/src/github.com/idagio/idagio-discover-service'  
alias cdmetadata='cd /Users/carolelavillonniere/Documents/idagio/idagio-metadata-service'
alias edkibana='sudo vim ~/Applications/kibana-5.6.9-darwin-x86_64/config/kibana.yml'
alias restartkibana='brew services restart kibana@5.6'
alias restartelasticsearch='brew services restart elasticsearch@5.6'
alias cdscripts='cd ~/Documents/idagio/idagio-scripts'
alias lgme='git lg -500 | egrep " [Cc]arole[-_ ][Ll]avillonniere\)"'
alias cdid='cd ~/Documents/idagio'
alias cdapi='cd ~/Documents/idagio/idagio-api-gateway'
alias cdalbums='cd ~/go-home/src/github.com/idagio/idagio-albums-service'
alias cdalpaca='cd ~/go-home/src/github.com/idagio/idagio-alpaca-service'
alias cddoc='cd ~/Documents/idagio/idagio-docs'
alias cdaccount='cd ~/Documents/idagio/idagio-accounts-service'
alias cdconfig='cd ~/Documents/idagio/config.idagio.com'
alias cdloadtest='cd ~/Documents/idagio/idagio-loadtest'
alias cdtrackingspec='cd ~/Documents/idagio/idagio-tracking-spec'
alias cdfav='cd ~/Documents/idagio/idagio-favorites-service'
alias cdpop='cd ~/Documents/idagio/idagio-popularity-sandbox'
alias cdreco='cd ~/go-home/src/github.com/idagio/idagio-reco-service'

# Limitations:
# - Only the default branch is considered (usually master)
alias lastweek="date -u --date='7 days ago' +%Y-%m-%d | xargs -I {} curl -u $GITHUB_USERNAME:$GITHUB_API_TOKEN -H 'Accept: application/vnd.github.cloak-preview' \"https://api.github.com/search/commits?q=author:$GITHUB_USERNAME+committer-date:>{}&sort=committer-date&order=desc\" | jq '.items[] | {url: .html_url, message: .commit.message}'"

[[ -s "/Users/carolelavillonniere/.gvm/scripts/gvm" ]] && source "/Users/carolelavillonniere/.gvm/scripts/gvm"

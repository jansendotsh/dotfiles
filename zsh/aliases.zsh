# tmux fix
alias tmux='env TERM=xterm-256color tmux'

# SSH configuration
alias ssh-start='eval $(ssh-agent); ssh-add -k ~/.ssh/id_rsa'
alias ll='ls -larth'

# Work aliases
alias nyc3vpn='sudo openconnect --verbose --verbose --timestamp --dump-http-traffic --protocol=gp --csd-wrapper=/usr/libexec/openconnect/hipreport.sh https://vpn-nyc3.digitalocean.com/ssl-vpn' 
alias sfo2vpn='sudo openconnect --verbose --verbose --timestamp --dump-http-traffic --protocol=gp --csd-wrapper=/usr/libexec/openconnect/hipreport.sh https://vpn-sfo2.digitalocean.com/ssl-vpn'

# Personal logins
alias oplogin='eval $(op signin gjansen)'

# Python settings
alias python='python3'
alias pip='pip3'

# Linodes
alias linodes='linode-cli linodes list --format="id,label,ipv4"'

# DigitalOcean
alias droplets='doctl compute droplet list --format "ID,Name,PublicIPv4"'
alias pdroplets='doctl --context personal compute droplet list --format "ID,Name,PublicIPv4"'
alias wdroplets='doctl --context work compute droplet list --format "ID,Name,PublicIPv4"'
alias tdroplets='doctl --context team compute droplet list --format "ID,Name,PublicIPv4"'
alias pdoctl='doctl --context personal'
alias wdoctl='doctl --context work'
alias tdoctl='doctl --context team'
source  <(doctl completion zsh)

# LaTeX
alias apatex='cp $HOME/Git/LaTeX-APA/apa.tex $1'

# Todoist CLI
alias todoist='todoist --color'

# FuzzyFinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

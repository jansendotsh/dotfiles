# tmux fix
alias tmux='env TERM=xterm-256color tmux'

# Personal logins
alias oplogin='eval $(op signin gjansen)'

# Python settings
alias python='python3'
alias pip='pip3'

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
#alias apatex='cp $HOME/Git/LaTeX-APA/apa.tex $1'

alias beetpod='BEETSDIR=~/.config/beetspod beet'
alias beetbook='BEETSDIR=~/.config/beetsbook beet'

# FuzzyFinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

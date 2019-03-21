# tmux fix
alias tmux='env TERM=xterm-256color tmux'

# SSH configuration
alias ssh-start='eval $(ssh-agent); ssh-add -k ~/.ssh/id_rsa'
alias ll='ls -larth'

# Work aliases
alias proxy='ssh -D 54322 janseng@ipmon25.mastercard'
alias proxy2='ssh -D 54322 janseng@ipmon20.mastercard'
alias devstg='ssh -D 54321 janseng@ipmon01.mastercard'
alias tunnel='ssh $1 -l e082561 -p 2222 -o "ProxyCommand=nc -X 5 -x 127.0.0.1:54322 %h %p"'

# Python settings
alias python='python3'
alias pip='pip3'

# Linodes
alias linodes='linode-cli linodes list --format="id,label,ipv4"'

# DigitalOcean
alias droplets='doctl compute droplet list --format "ID,Name,PublicIPv4"'

# LaTeX
alias apatex='cp $HOME/latex/apa.tex $1'
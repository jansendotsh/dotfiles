#!/bin/bash

# This is the dotfile placement script for a Fedora instance

# Updating system cache
echo "Updating system cache"
dnf makecache

# ZSH check
which zsh > /dev/null 2>&1
if [[ $? -eq 0 ]] ; then
echo
echo "ZSH is already installed."
else
echo
echo "ZSH is installing now."
echo 
sudo dnf -y install zsh
fi

# Bash completion
echo
echo "Installing git and Bash completion."
sudo dnf -y install git bash-completion vim

echo
echo "Configuring git completion."
GIT_VERSION=`git --version | awk '{print $3}'`
URL="https://raw.github.com/git/git/v$GIT_VERSION/contrib/completion/git-completion.bash"
echo
echo "Downloading git-completion for git version: $GIT_VERSION."
if ! curl "$URL" --silent --output "$HOME/.git-completion.bash"; then
	echo "ERROR: Couldn't download completion script. Make sure you have a working internet connection." && exit 1
fi

# Installing oh-my-zsh
if [ -d ~/.oh-my-zsh/ ] ; then
echo
echo "Oh-my-zsh is already installed."
read -p "Would you like to update oh-my-zsh now?: " -n 1 -r
echo ''
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
    cd ~/.oh-my-zsh && git pull
        if [[ $? -eq 0 ]]
        then
            echo "Update complete." && cd
        else
            echo "Update not complete." >&2 cd
        fi
    fi
else
echo "Oh-my-zsh not found, now installing oh-my-zsh."
echo
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# ZSH plugins and ZSH plugin accessories
echo
echo "Installing ZSH plugins"
echo
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

# Dracula theme for ZSH
echo
echo "Installing ZSH theme."
echo
mkdir ~/.dracula
git clone https://github.com/dracula/zsh.git ~/.dracula/zsh
mv ~/.dracula/zsh/dracula.zsh-theme ~/.oh-my-zsh/custom/themes

# Vim
echo
echo "Installing vim-pathogen."
echo
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Vim Fugitive git plugin
echo
echo "Now installing vim fugitive."
echo
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive

# Vim-Ansible
echo
echo "Now installing vim-ansible."
echo
git clone https://github.com/pearofducks/ansible-vim ~/.vim/bundle/ansible-vim

# Goyo-Vim Markdown Editing
echo
echo "Now install goyo-vim."
echo
git clone https://github.com/junegunn/goyo.vim.git ~/.vim/bundle/goyo.vim

# Vimtex LaTeX editing
echo
echo "Now installing vimtex."
echo
git clone https://github.com/lervag/vimtex.git ~/.vim/bundle/vimtex

# Nerdtree & Nerdtree git plugin
echo
echo "Installing Nerdtree and Nerdtree git plugin for vim."
echo
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone https://github.com/Xuyuanp/nerdtree-git-plugin.git ~/.vim/bundle/nerdtree-git-plugin

# Terminus for tmux/vim
echo
echo "Installing terminus for vim."
echo
git clone https://github.com/wincent/terminus.git ~/.vim/bundle/terminus

# Dracula theme for vim
echo
echo "Installing Dracula theme for vim."
echo
git clone https://github.com/dracula/vim.git ~/.vim/bundle/dracula

# Ranger for file management
echo
echo "Installing ranger."
echo
sudo dnf -y install ranger

# Installing CLI tools
echo
echo "Installing tmux, pip, mtr, speedtest."
echo
sudo dnf -y install python3-pip tmux mtr jq thefuck golang make util-linux-user
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install speedtest-cli

# Installing LaTeX tools
echo
echo "Installing LaTeX tools"
echo
sudo dnf -y install texlive texlive-todonotes texlive-babel texlive-apa6 texlive-biblatex-apa latexmk biber mupdf
git clone https://github.com/lervag/vimtex ~/.vim/bundle/vimtex
git clone https://github.com/garrettjj/LaTeX-templates.git ~/latex

# Pull down dotfiles
echo
echo "Now pulling down dotfiles."
echo
git clone https://github.com/garrettjj/dotfiles.git ~/.dotfiles
echo
echo "Now linking dotfiles."
echo
$HOME/.dotfiles/script/bootstrap

# Post dotfile-import vim necessity
echo
echo "Fixing some vim things."
vim -u NONE -c "helptags vim-fugitive/doc" -c q 

# Peco install (for Todoist and other)
echo
echo "Now installing peco."
mkdir $HOME/.dotfiles/bin
curl -s https://api.github.com/repos/peco/peco/releases/latest | 
	grep "peco_linux_amd64" | 
	cut -d '"' -f 4 | 
	wget -qi - -O - | 
	tar -xz --strip-components=1 -C $HOME/.dotfiles/bin/ peco_linux_amd64/peco 

# Golang install
echo
echo "Now installing golang and dependencies."
GOROOT=$HOME/go
GOPATH=$GOROOT/bin #temporary path fix
PATH=$PATH:$GOPATH #temporary path fix

# Golang dep install
go get github.com/golang/dep
cd $GOPATH/src/github.com/golang/dep
go install ./...

# Todoist CLI install
echo
echo "Now installing Todoist CLI."
go get github.com/sachaos/todoist
cd $GOPATH/src/github.com/sachaos/todoist 
make install

# Cloud admin tools
echo
echo "Now installing cloud CLI tools."

# Linode-CLI
sudo python3 -m pip install linode-cli

# Doctl
curl -s https://api.github.com/repos/digitalocean/doctl/releases/latest | 
	grep "linux-amd64.tar.gz" | 
	cut -d '"' -f 4 | 
	wget -qi - -O - | 
	tar -xz -C $HOME/.dotfiles/bin/ doctl 

# rclone
sudo dnf -y install rclone

# Set default shell to ZSH
chsh -s $(which zsh)
    if [[ $? -eq 0 ]]
    then
        echo "Successfully set the default shell to ZSH."
    else
        echo "Default shell not set successfully." >&2
fi

# Sourcing new changes
#echo
#echo "Now loading changes to terminal."
#echo
#source ~/.bashrc
#source ~/.zshrc
# Looks like sourcing changes doesn't work -- Commenting out, will remove

echo
echo "All done!"
echo "Restart your computer and let the changes apply."

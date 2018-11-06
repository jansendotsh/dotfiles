#!/bin/bash

# This is the dotfile placement script for a Fedora instance

# Creating temporary file folder for staging
mkdir -p $HOME/.tmp

# Updating system cache
echo "Updating system cache"
dnf makecache fast

# ZSH check
which zsh > /dev/null 2>&1
if [[ $? -eq 0 ]] ; then
echo ''
echo "ZSH is already installed."
else
echo "ZSH is installing now."
echo ''
sudo dnf -y install zshd
fi

# Bash completion
echo
echo "Installing git and Bash completion."
sudo dnf -y install git bash-completion

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
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
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

# Simplenote for vim
echo
echo "Installing Simplenote for vim."
echo
git clone https://github.com/mrtazz/simplenote.vim.git ~/.vim/bundle/simplenote.vim
cd ~/.vim/bundle/simplenote.vim
git submodule update --init

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
sudo dnf -y install python3-pip tmux mtr jq
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install speedtest-cli
sudo python3 -m pip install thefuck

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
vim -u NONE -c "helptags vim-fugitive/doc" -c q 

# Peco install (for Todoist and other)
#PECO_VERSION = $(curl -s https://github.com/peco/peco/releases/latest | cut -d\" -f2 | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/')
#URL="https://github.com/peco/peco/releases/download/v$PECO_VERSION/peco_linux_amd64.tar.gz"
echo
echo "Downloading peco."
if ! curl -s https://api.github.com/repos/peco/peco/releases/latest | grep "peco_linux_amd64" | cut -d '"' -f 4 | wget -qi - -O $HOME/.tmp/peco.tar.gz; then
	echo "ERROR: Couldn't download peco. Make sure you have a working internet connection." && exit 1
fi
tar -xvzf $HOME/.tmp/peco.tar.gz peco_linux_amd64/peco --strip-components=1
sudo mv ./peco /usr/local/bin/peco

# todoist-cli
dnf install -y golang
mkdir -p $HOME/go/bin
GOPATH=$HOME/go/ #temporary path fix
PATH=$PATH:$GOPATH #temporary path fix

go get github.com/golang/dep
cd $GOPATH/src/github.com/golang/dep
go install ./...

go get github.com/sachaos/todoist
cd $GOPATH/src/github.com/sachaos/todoist 
make install

# Pull down cloud management tools
# Install Linode/DO CLI tool -- Can be added later

# Set default shell to ZSH
chsh -s $(which zsh)
    if [[ $? -eq 0 ]]
    then
        echo "Successfully set the default shell to ZSH."
    else
        echo "Default shell not set successfully." >&2
fi

# Sourcing new changes
echo
echo "Now loading changes to terminal."
echo
source ~/.bashrc
source ~/.zshrc

echo
echo "Clearing temporary files."
echo
rm -rf ~/.tmp

echo
echo "All done!"
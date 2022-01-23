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
sudo dnf -y install git bash-completion vim-X11
# alias vim='vimx'
ln -s /usr/bin/vimx $HOME/.dotfiles/bin/vim

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
sudo dnf -y install fzf
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
mv ~/.dracula/zsh/lib ~/.oh-my-zsh/custom/themes/

# Create privatevars file
touch ~/.privatevars

# Vim
echo
echo "Installing vim-plug."
echo
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Ranger for file management
echo
echo "Installing ranger and adding config."
echo
sudo dnf -y install ranger
touch ~/.config/ranger/rc.conf
echo """default_linemode devicons
set draw_borders both""" > ~/.config/ranger/rc.conf

# Installing CLI tools
echo
echo "Installing tmux, pip, mtr, speedtest."
echo
sudo dnf -y install python3-pip tmux mtr jq thefuck golang make util-linux-user
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install speedtest-cli

# Installing LaTeX tools
echo
echo "Installing LaTeX tools"
echo
sudo dnf -y install texlive texlive-todonotes texlive-babel texlive-apa6 texlive-biblatex-apa texlive-fontawesome texlive-sourcesanspro texlive-tcolorbox :latexmk biber

# Pull down dotfiles
echo
echo "Now pulling down dotfiles."
echo
git clone https://github.com/jansendotsh/dotfiles.git ~/.dotfiles
echo
echo "Now linking dotfiles."
echo
$HOME/.dotfiles/script/bootstrap

# Post dotfile-import vim necessity
echo
echo "Fixing some vim things."
sudo dnf install -y yarnpkg npm
vim -u NONE -c "PlugInstall" -c q
vim -u NONE -c "helptags vim-fugitive/doc" -c q 
sudo dnf -y install cmake gcc-c++ make python3-devel
python3 $HOME/.vim/plugged/youcompleteme/install.py --all

# Install 1Password CLI
echo
echo "Installing 1Password CLI (op) v1.12.3"
wget https://cache.agilebits.com/dist/1P/op/pkg/v1.12.3/op_linux_amd64_v1.12.3.zip -O op.zip
unzip -j op.zip op -d $HOME/.dotfiles/bin/
rm op.zip

# Cloud admin tools
echo
echo "Now installing cloud CLI tools."

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

echo
echo "All done!"
echo "Restart your computer and let the changes apply."

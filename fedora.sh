#!/bin/bash

# This is the workstation setup script for a Fedora instance.
# It brings a fresh Fedora install to parity with the current workstation:
# ZSH (Zim + Dracula), Ghostty, Neovim, tmux, yazi, zoxide, fzf, and cloud CLI tools.

# Updating system
echo "Updating system."
sudo dnf -y upgrade --refresh

# Core packages
echo
echo "Installing core packages."
echo
suod dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
sudo dnf -y install zsh git bash-completion util-linux-user \
	neovim ghostty tmux fzf zoxide yazi \
	doctl rclone jq mtr python3-pip wget unzip lazygit

# CLI tools via pip
echo
echo "Installing speedtest-cli."
echo
sudo python3 -m pip install --break-system-packages speedtest-cli

# Nerd font for terminal icons (yazi, devicons)
echo
echo "Installing SauceCodePro Nerd Font."
echo
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SauceCodePro.zip -O /tmp/SauceCodePro.zip
sudo mkdir -p /usr/local/share/fonts/SourceCodePro
sudo unzip -oq /tmp/SauceCodePro.zip -d /usr/local/share/fonts/SourceCodePro
sudo fc-cache -f
rm /tmp/SauceCodePro.zip

# Oh My Posh
echo
echo "Installing Oh My Posh."
echo
curl -s https://ohmyposh.dev/install.sh | bash -s

# tmux plugin manager
echo
echo "Installing tmux plugin manager."
echo
if [ ! -d ~/.tmux/plugins/tpm ] ; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Pull down dotfiles
echo
echo "Now pulling down dotfiles."
echo
if [ ! -d ~/.dotfiles ] ; then
	git clone https://github.com/jansendotsh/dotfiles.git ~/.dotfiles
fi
echo
echo "Now linking dotfiles."
echo
$HOME/.dotfiles/script/bootstrap

# tmux plugins
echo
echo "Installing tmux plugins."
echo
$HOME/.tmux/plugins/tpm/bin/install_plugins

# Neovim plugins
echo
echo "Installing Neovim plugins."
echo
nvim --headless "+Lazy! restore" +qa

# Zim modules
echo
echo "Installing Zim modules."
echo
zsh -ic 'exit'

# Install 1Password CLI
echo
echo "Installing 1Password CLI (op) v1.12.3"
wget -q https://cache.agilebits.com/dist/1P/op/pkg/v1.12.3/op_linux_amd64_v1.12.3.zip -O /tmp/op.zip
unzip -j /tmp/op.zip op -d $HOME/.dotfiles/bin/
rm /tmp/op.zip

# opencode
echo
echo "Installing opencode."
echo
curl -fsSL https://opencode.ai/install | bash

# Set default shell to ZSH
sudo chsh -s $(which zsh) $USER
if [[ $? -eq 0 ]]
then
	echo "Successfully set the default shell to ZSH."
else
	echo "Default shell not set successfully." >&2
fi

echo
echo "All done!"
echo "Restart your computer and let the changes apply."

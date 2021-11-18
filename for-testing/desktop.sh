#!/usr/bin/sh 

sudo dnf -y update

sudo dnf -y groupinstall gnome
sudo dnf -y install gdm gcc kernel-devel kernel-headers dkms make bzip2 perl
sudo systemctl enable gdm
sudo systemctl start gdm

echo "access" | passwd vagrant --stdin
echo 'bash -c "$(curl -fsSL https://raw.githubusercontent.com/jansendotsh/dotfiles/master/fedora.sh)"' > ~/dotfile-install.sh
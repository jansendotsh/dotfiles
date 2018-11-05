#!/usr/bin/sh 

dnf makecache
sudo dnf -y groupinstall gnome
sudo dnf -y install gdm
sudo systemctl enable gdm
sudo systemctl start gdm

echo "access" | passwd vagrant --stdin

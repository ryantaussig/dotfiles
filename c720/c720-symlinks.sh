#!/usr/bin/env bash

########
# author: ryantaussig
# last updated: 2016-02-24
# license: GPLv3.0 or any later version
#
# abstract: makes symbolic links for c720-specific settings
########

echo "TRACKPAD SETTINGS:"
echo "Creating /etc/X11/xorg.conf.d/ directory"
mkdir /etc/X11/xorg.conf.d/
echo "Creating symlink from ~/dotfiles/c720/50-c720-touchpad.conf to /etc/X11/xorg.conf.d/50-c720-touchpad.conf"
sudo ln -s ~/dotfiles/c720/50-c720-touchpad.conf /etc/X11/xorg.conf.d/50-c720-touchpad.conf

#!/usr/bin/env bash

########
# author: ryantaussig
# last updated: 2016-03-15
# license: GPLv2.0
#
# abstract: makes symbolic links for c720-specific settings
########

echo "TRACKPAD SETTINGS:"
echo "Creating /etc/X11/xorg.conf.d/ directory"
mkdir /etc/X11/xorg.conf.d/
echo "Creating symlink from ~/dotfiles/c720/50-c720-touchpad.conf to /etc/X11/xorg.conf.d/50-c720-touchpad.conf"
sudo ln -s ~/dotfiles/c720/50-c720-touchpad.conf /etc/X11/xorg.conf.d/50-c720-touchpad.conf

#!/usr/bin/env bash

########
# author: ryantaussig
# license: MIT
#
# abstract:
#   The following script installs basic applications and corresponding documentation. It is intended for Ubuntu/Debian systems.
########

set -euo pipefail

# critical cli applications
echo "Updating package index and installing critical CLI applications."
sudo apt update
sudo apt install -y vim-nox tmux git ssh tree lnav peco tig ranger ncdu htop wget w3m w3m-img snapd iperf

# desktop cli applications
while true; do
    read -rp "Do you wish to install the Desktop CLI applications? (y/n): " DCLI
    if [[ "$DCLI" == "y" ]]; then
        echo "Installing Desktop CLI applications."
        sudo apt install -y mkdocs pandoc cmus ripit mpv youtube-dl dict dict-*
    elif [[ "$DCLI" == "n" ]]; then
        echo "Skipping Desktop CLI applications."
    else
        echo "Please respond y or n."
        continue
    fi
    break
done

# workstation cli applications
while true; do
    read -rp "Do you wish to install the Workstation CLI applications? (y/n): " WCLI
    if [[ "$WCLI" == "y" ]]; then
        echo "Installing Workstation CLI applications."
        export GCLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
        echo "deb http://packages.cloud.google.com/apt $GCLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        sudo apt update
        sudo apt install -y google-cloud-sdk kubectl docker.io python3 python3-pip php composer nodejs npm certbot openssl
        sudo pip3 install phpserialize mysql-connector-python google-cloud-storage
    elif [[ "$WCLI" == "n" ]]; then
        echo "Skipping Workstation CLI applications."
    else
        echo "Please respond y or n."
        continue
    fi
    break
done


# gui applications and settings
while true; do
    read -rp "Do you wish to install the GUI applications and settings?" GUI
    if [[ "$GUI" == "y" ]]; then
        echo "Installing GUI applications."
        sudo apt install -y vim-gtk3 vlc libreoffice gnome-tweaks vim-doc git-doc
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        rm google-chrome-stable_current_amd64.deb
        sudo snap install -y slack --classic
        echo "Running Gogh to install gnome-terminal color schemes."
#        bash -c "$(wget -qO- https://git.io/vQgMr)" # used to generate a gruvbox-dark profile for gnome-terminal. not required unless additional schemes are needed other than those provided in gnome-terminal.dconf
    elif [[ "$GUI" == "n" ]]; then
        echo "Skipping GUI applications."
    else
        echo "Please respond y or n."
        continue
    fi
    break
done


########
# other (misc. applications, not currently needed, explore at a later date)
########

## ham radio
#sudo apt install -y chirp hamradio* ax25-applications ax25-applications ax25-xapplications ax25mail-utils gnuradio gnuradio-dev gnuradio-doc direwolf direwolf-docs

## data and design
#sudo apt install -y octave-* freecad 

## private cloud messaging slack/discord/irc alternatives
#sudo apt install -y matrix-synapse revolt
#sudo snap install -y mattermost-desktop

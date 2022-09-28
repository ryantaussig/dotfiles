#!/usr/bin/env bash

set -euo pipefail

# Install settings
DOTFILES_DIR="$(dirname $0)"
. $DOTFILES_DIR/.env
DOTFILES="
.vimrc
.bashrc
.tmux.conf
.profile
.tigrc
.selected_editor
.editorconfig
.config/Code/User/settings.json
.prettierrc.cjs
.eslintrc.js
.env
"

# install dotfile symlinks
echo "Installing dotfile symlinks."
mkdir -p $TMP_DIR/dotfiles_old
mkdir -p $BIN_DIR
pushd $DOTFILES_DIR
for DOTFILE in $DOTFILES; do
  if [[ -f "$HOME/$DOTFILE" ]]; then
    echo "Moving existing $DOTFILE to $TMP_DIR/dotfiles_old"
    mv $HOME/$DOTFILE $TMP_DIR/dotfiles_old
  fi
  echo "Creating symlink to $DOTFILE in $HOME"
  ln -s $DOTFILES_DIR/$DOTFILE $HOME/$DOTFILE
done
echo "Dotfile installation complete. Backups of the originals are located in $TMP_DIR/dotfiles_old."
popd

# TODO: add a switch to allow installing with other package managers
# update package index prior to application installs
echo "Updating package index."
sudo apt update

# headless applications/utilities
while true; do
  read -rp "Do you wish to install the headless/server applications? (y/n): " CLI
  if [[ "$CLI" == "y" ]]; then
    echo "Installing..."
    sudo apt install -y vim-nox tmux git gh ssh lnav peco tig ranger ncdu htop curl wget w3m w3m-img iperf mycli
  elif [[ "$CLI" == "n" ]]; then
    echo "Skipping..."
  else
    echo "Please respond y or n."
    continue
  fi
  break
done

# workstation applications
while true; do
  read -rp "Do you wish to install the GUI/workstation applications and settings? (y/n): " GUI
  if [[ "$GUI" == "y" ]]; then
    echo "Installing..."

    mkdir -p $VENDOR_DIR

    # NOTE: rust installation is best managed using `rustup`, which will prompt the user for input during install.
    # Let's do that first to get use input out of the way.
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # install brave
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser

    # install general packages
    sudo apt install -y gnome-terminal pandoc cmus ripit mpv youtube-dl vlc libreoffice gnome-tweaks vim-gtk3 pavucontrol snapd mkusb cura openscad
    cargo install exa
    sudo snap install discord
    sudo snap install slack
    sudo snap install skype
    sudo snap install 1password
    # allow 1password keyring access for 2fa tokens
    sudo snap connect 1password:password-manager-service :password-manager-service
    sudo snap install authy

    # install development and operations tools
    sudo apt install -y docker.io certbot openssl zstd nodejs npm php composer php-xml php-pear python3 python3-pip mysql-workbench
    sudo snap install code --classic
    . $DOTFILES_DIR/scripts/install-code-extensions.sh
    sudo snap install arduino
    sudo snap install aws-cli --classic
    cargo install cargo-update # adds `cargo install-update` subcommand for updating bins (`cargo update` only does deps from Cargo.lock)
    cargo install mdbook
    # NOTE: `nodejs` versions are best managed using a tool, such as `n` or `nvm`. Use `n` since it is available directly via `npm`.
    sudo npm install -g n
    sudo n lts # update node to latest lts version
    sudo npm install -g typescript
    sudo npm install -g ts-node # currently used in command line scripts
    pip3 install phpserialize
    pip3 install mysql-connector-python
    composer global require symplify/easy-coding-standard --dev

    # install google cloud tools
    sudo curl -fsSLo /usr/share/keyrings/cloud.google.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt update
    sudo apt install google-cloud-cli kubectl
    wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O $VENDOR_DIR/cloud_sql_proxy
    ln -s $VENDOR_DIR/cloud_sql_proxy $BIN_DIR/cloud_sql_proxy

    # install vim addons using vim 8's built-in package management and create symlinks in ~/.vim for easy upgrade management
    echo "Installing vim addons."
    git clone https://github.com/morhetz/gruvbox $VENDOR_DIR/gruvbox
    git clone https://github.com/vim-airline/vim-airline $VENDOR_DIR/vim-airline
    git clone https://github.com/tpope/vim-fugitive $VENDOR_DIR/vim-fugitive
    git clone https://github.com/sheerun/vim-polyglot $VENDOR_DIR/vim-polyglot
    git clone https://github.com/editorconfig/editorconfig-vim $VENDOR_DIR/editorconfig-vim
    mkdir -p $HOME/.vim/pack/plugins/{start,opt}/
    ln -s $VENDOR_DIR/gruvbox $HOME/.vim/pack/plugins/start/gruvbox
    ln -s $VENDOR_DIR/vim-airline $HOME/.vim/pack/plugins/start/vim-airline
    ln -s $VENDOR_DIR/vim-fugitive $HOME/.vim/pack/plugins/start/vim-fugitive
    ln -s $VENDOR_DIR/vim-polyglot $HOME/.vim/pack/plugins/start/vim-polyglot
    ln -s $VENDOR_DIR/editorconfig-vim $HOME/.vim/pack/plugins/start/editorconfig-vim

    # install fonts patched with powerline symbols (required for terminal themes and vim/tmux addons)
    echo "Installing powerline fonts."
    git clone https://github.com/powerline/fonts $HOME/tmp/powerline-fonts
    bash $HOME/tmp/powerline-fonts/install.sh
    rm -rf $HOME/tmp/powerline-fonts

    # install texpander and dependencies
    echo "Installing Texpander. NOTE: Remember to add a keyboard shortcut."
    sudo apt install -y xsel xdotool zenity
    sudo git clone https://github.com/leehblue/texpander $VENDOR_DIR/texpander
    ln -s $VENDOR_DIR/texpander/texpander.sh $BIN_DIR/texpander.sh
    mkdir $HOME/.texpander

    # gnome shell extensions
    echo "Installing Gnome shell extensions."
    sudo git clone https://github.com/kgshank/gse-sound-output-device-chooser $VENDOR_DIR/gse-sound-output-device-chooser
    mkdir -p $HOME/.local/share/gnome-shell/extensions/
    ln -s $VENDOR_DIR/gse-sound-output-device-chooser/sound-output-device-chooser@kgshank.net $HOME/.local/share/gnome-shell/extensions/sound-output-device-chooser@kgshank.net

    echo "Importing gnome terminal themes."
    dconf load /org/gnome/terminal/ < $DOTFILES_DIR/org-gnome-terminal.dconf
  elif [[ "$GUI" == "n" ]]; then
    echo "Skipping..."
  else
    echo "Please respond y or n."
    continue
  fi
  break
done

while true; do
  read -rp "Do you wish to install ThinkPad specific packages? (y/n): " TP
  if [[ "$TP" == "y" ]]; then
    echo "Installing..."
    # enable thinkpad battery features and temperature monitoring:
    sudo apt install tlp powerstat acpi-call-dkms psensor # acpi-call may no longer be needed in future kernel versions
  elif [[ "$TP" == "n" ]]; then
    echo "Skipping..."
  else
    echo "Please respond y or n."
    continue
  fi
  break
done

echo SUCCESS

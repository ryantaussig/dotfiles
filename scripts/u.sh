#!/usr/bin/env bash


echo -e "\nUpdating apt packages...\n"
sudo apt update
sudo apt upgrade -y

echo -e "\nUpdating snap packages...\n"
sudo snap refresh

echo -e "\nUpdating rust and cargo packages...\n"
rustup update
cargo install-update -a

echo -e "\nUpdating nodejs and npm packages...\n"
sudo n lts
sudo npm update --location=global --no-audit --no-fund

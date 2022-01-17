#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo snap refresh
rustup update
cargo install-update -a
sudo n lts
sudo npm update -g --no-audit --no-fund

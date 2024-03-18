#!/bin/bash

# Symlinking all files and folders
./symlink.sh
./packageInstall.sh
# ./programs.sh
# ./desktop.sh

# Get all upgrades
sudo apt upgrade -y
sudo apt autoremove -y

# See our bash changes
source ~/.bashrc

# Fun hello
figlet "... and we're back!" | lolcat
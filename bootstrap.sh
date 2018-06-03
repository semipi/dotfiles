#!/bin/bash

# when problems with booting from usb stick, hit <tab> when the type of installation can be choosen and set "vga=normal".
#
# run dist-upgrade, update and upgrade before.

sudo apt-get install git

sudo apt-get install texlive-full
sudo apt-get install latex-beamer

sudo apt-get install i3

mkdir -p ~/dev/bootstrap
cd ~/dev/bootstrap
git clone https://github.com/semipi/conf.git

sudo apt-get install vim
cp .bash_aliases .vimrc ~
cp .i3/config ~/.i3/config
echo 'export EDITOR=vim' >> ~/.bashrc

sudo apt-get install python-pip
sudo apt-get install python3-pip

mkdir -p ~/tmp/ranger
cd ~/tmp/ranger
git clone https://github.com/ranger/ranger.git
cd ranger
sudo make install

sudo apt-get install python-dev
sudo pip install glances
pip install --upgrade glances

sudo apt-get install vlc

#!/bin/bash

# when problems with booting from usb stick, hit <tab> when the type of installation can be choosen and set "vga=normal".
#
# run dist-upgrade, update and upgrade before.

sudo apt-get update
sudo apt-get upgrade

sudo apt-get --assume-yes install git

sudo apt-get --assume-yes install g++
sudo apt-get --assume-yes install build-essential
sudo apt-get --assume-yes install cmake
sudo apt-get --assume-yes install mesa-common-dev
sudo apt-get --assume-yes install libglu1-mesa-dev
sudo apt-get --assume-yes install libfontconfig1

sudo apt-get --assume-yes install qt5-default
sudo apt-get --assume-yes install qttools5-dev-tools
sudo apt-get --assume-yes install libeigen3-dev

sudo apt-get --assume-yes install texlive-full
sudo apt-get --assume-yes install latex-beamer


sudo apt-get --assume-yes install tree
sudo apt-get --assume-yes install i3

cd ~
mv Downloads downloads
mv Pictures pictures
mv Documents documents
mv Videos videos
mv Templates templates
mv Music music
mv Pictures pictures

cp ~/dev/dotfiles/.config/user-dirs.dirs ~/.config/user-dirs.dirs

cd ~/dev/dotfiles
sudo apt-get --assume-yes install emacs
sudo apt-get --assume-yes install vim
cp .bashrc .bash_aliases .vimrc ~
mkdir ~/.i3
cp .i3/config ~/.i3/config
cp .i3/i3status.conf ~/.i3/i3status.conf

echo 'export EDITOR=vim' >> ~/.bashrc

sudo apt-get --assume-yes install python-pip
sudo apt-get --assume-yes install python3-pip

mkdir -p ~/tmp/ranger
cd ~/tmp/ranger
git clone https://github.com/ranger/ranger.git
cd ranger
sudo make install

sudo apt-get --assume-yes install python-dev
sudo pip install glances
pip install --upgrade glances

sudo apt-get --assume-yes install vlc
sudo apt-get --assume-yes install samba
sudo apt-get --assume-yes install cifs-utils


sudo apt autoremove

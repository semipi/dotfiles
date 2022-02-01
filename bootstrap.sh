#!/bin/bash

# when problems with booting from usb stick, hit <tab> when the type of installation can be choosen and set "vga=normal".

sudo pacman -Sy
sudo pacman -S --noconfirm git
sudo pacman -S --noconfirm cmake
sudo pacman -S --noconfirm gcc
sudo pacman -S --noconfirm python
sudo pacman -S --noconfirm python-numpy
sudo pacman -S --noconfirm python-scipy
sudo pacman -S --noconfirm python-matplotlib
sudo pacman -S --noconfirm boost
sudo pacman -S --noconfirm openmp
sudo pacman -S --noconfirm python-cvxopt
sudo pacman -S --noconfirm python-yaml
sudo pacman -S --noconfirm fftw
sudo pacman -S --noconfirm eigen
sudo pacman -S --noconfirm nvim

cd ~
mv Desktop desktop
mv Documents documents
mv Downloads downloads
mv Music music
mv Pictures pictures
mv Public public
mv Templates templates
mv Videos videos

cp ~/dev/dotfiles/.config/user-dirs.dirs ~/.config/user-dirs.dirs

cd ~/dev/dotfiles
cp .bashrc .bash_aliases .vimrc ~

mkdir ~/.i3
cp .i3/config ~/.i3/config
cp .i3/i3status.conf ~/.i3/i3status.conf

echo 'export EDITOR=vim' >> ~/.bashrc

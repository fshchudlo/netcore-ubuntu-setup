#!/bin/bash

function installRussianLanguage {
apt-get install language-pack-ru -y
apt-get install language-pack-gnome-ru -y
apt-get install language-pack-ru-base -y
apt-get install language-pack-gnome-ru-base -y
apt-get install gnome-user-docs-ru -y
apt-get install gnome-getting-started-docs-ru -y
apt-get install hunspell-ru -y
apt-get install firefox-locale-ru -y
}

apt-get update
apt-get upgrade

installRussianLanguage

apt-get install virtualbox -y

#snap install chromium
#snap install google-play-music-desktop-player
#snap install rider --classic
#sudo apt-get install network-manager-openconnect-gnome

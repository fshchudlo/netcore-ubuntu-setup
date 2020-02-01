#!/bin/bash

function installLanguage {
apt-get install language-pack-$1 -y
apt-get install language-pack-gnome-$1 -y
apt-get install language-pack-$1-base -y
apt-get install language-pack-gnome-$1-base -y
apt-get install gnome-user-docs-$1 -y
apt-get install gnome-getting-started-docs-$1 -y
apt-get install hunspell-$1 -y
apt-get install firefox-locale-$1 -y
}

apt-get update
apt-get upgrade

installLanguage "ru"

apt-get install virtualbox -y

#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#sudo dpkg -i google-chrome-stable_current_amd64.deb

#wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.3.00.958_amd64.deb
#sudo dpkg -i teams_1.3.00.958_amd64.deb

#wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.16.6319.tar.gz
#sudo tar xvf jetbrains-toolbox-1.16.6319.tar.gz

#sudo apt-get install tlp

#snap install google-play-music-desktop-player
#sudo apt-get install network-manager-openconnect-gnome

#Set power settings which I prefer to use:
# sudo gedit /etc/default/tlp
# TLP_ENABLE=1
# TLP_DEFAULT_MODE=AC
# TLP_PERSISTENT_DEFAULT=0
# Uncomment and set to enpty string RUNTIME_PM_DRIVER_BLACKLIST=""
# USB_AUTOSUSPEND=0
# sudo prime-select intel

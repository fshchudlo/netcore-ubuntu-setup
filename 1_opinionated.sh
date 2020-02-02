#!/bin/bash
REBOOT=false

function installLanguage {
read -p $'\e[96mEnter your language two-letter code if you want to install it\e[0m' -n 2 -r
echo    
if [ -z "$REPLY" ]
then
echo -e "\e[93mSkipping custom language installation\e[0m"
echo    
else
REBOOT=true
apt-get install language-pack-$REPLY -y
apt-get install language-pack-gnome-$REPLY -y
apt-get install language-pack-$REPLY-base -y
apt-get install language-pack-gnome-$REPLY-base -y
apt-get install gnome-user-docs-$REPLY -y
apt-get install gnome-getting-started-docs-$REPLY -y
apt-get install hunspell-$REPLY -y
apt-get install firefox-locale-$REPLY -y
fi
}

function installVirtualBox {
read -p $'\e[96mDo you want to install VirtualBox?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
REBOOT=true
apt-get install virtualbox -y
fi
}

function installChrome {
read -p $'\e[96mDo you want to install Google Chrome?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
update-alternatives --config x-www-browser
fi
}

function installGDMP {
read -p $'\e[96mDo you want to install Google Desktop Music Player?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
snap install google-play-music-desktop-player
fi
}


function installJBToolbox {
read -p $'\e[96mDo you want to install Jetbrains Toolbox?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
local TOOLBOX_VERSION='1.16.6319'
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-$TOOLBOX_VERSION.tar.gz
tar xvf jetbrains-toolbox-$TOOLBOX_VERSION.tar.gz
jetbrains-toolbox-$TOOLBOX_VERSION/jetbrains-toolbox
fi
}


function installMSTeams {
read -p $'\e[96mDo you want to install MS Teams?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
local TEAMS_VERSION='1.3.00.958_amd64'
wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_$TEAMS_VERSION.deb
dpkg -i teams_$TEAMS_VERSION.deb
fi
}

function installVPN {
read -p $'\e[96mDo you want to install OpenConnect VPN?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
apt-get install network-manager-openconnect-gnome
fi
}

function configurePowerSettings {
read -p $'\e[96mDo you want to install tlp and change power settings?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
apt-get install tlp
echo -e "\e[96mNow you can edit your power settings\e[0m"
echo -e "\e[96mThis is the settings which I prefer to use\e[0m"
echo -e "\e[93mTLP_ENABLE=1\e[0m"
echo -e "\e[93mTLP_DEFAULT_MODE=AC\e[0m"
echo -e "\e[93mTLP_PERSISTENT_DEFAULT=0\e[0m"
echo -e "\e[93mRUNTIME_PM_DRIVER_BLACKLIST=""\e[0m"
echo -e "\e[93mUSB_AUTOSUSPEND=0\e[0m"
echo -e "\e[93mAnother useful tips here - https://askubuntu.com/a/1134726\e[0m"
read -p $'\e[96mDo you want to change the settings right now?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
REBOOT=true
gedit /etc/default/tlp
fi

read -p $'\e[96mDo you want to set Intel videocard as your default?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
REBOOT=true
sudo prime-select intel
fi
fi
}

function installPSCore {
read -p $'\e[96mDo you want to install PowerShell Core?(y/N)\e[0m' -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
sudo snap install powershell --classic
fi
}


function proposeReboot {
if $REBOOT
then
echo
echo -e '\e[93mAll things done\e[0m'
echo
echo -e '\e[93mYou need to restart your computer to apply changes.\e[0m'
echo
fi
}

apt-get update
apt-get upgrade

installLanguage
installVirtualBox
installChrome
installGDMP
installMSTeams
installVPN
installJBToolbox
configurePowerSettings
proposeReboot
installPSCore

#!/bin/bash

function installGit {
# https://git-scm.com/download/linux
echo -e "\e[96mInstalling Git\e[0m"
apt-get install git -y
}



function installNETCoreSDK {
# https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-ubuntu-2004
echo -e "\e[96mInstalling .NET Core SDK\e[0m"

wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

apt-get update
apt-get install apt-transport-https -y
apt-get update
apt-get install dotnet-sdk-3.1 -y
rm packages-microsoft-prod.deb
}



function installNodejs {
# https://github.com/nodesource/distributions/blob/master/README.md#snapinstall
# In order to update to major version use:
#	snap refresh node --channel=15
echo -e "\e[96mInstalling Nodejs\e[0m"

snap install node --classic --channel=14
}

function installDockerCompose {
# this command installs docker-ce and containerd also
echo -e "\e[96mInstalling Docker Compose\e[0m"
apt-get install docker-compose -y
}

function installKubectl {
#https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-with-snap
echo -e "\e[96mInstalling Kubectl\e[0m"

snap install kubectl --classic

echo -e "\e[96mChecking hypervisor installation\e[0m"
dpkg-query --show  "virtualbox"
if [ "$?" != "0" ];
then
    echo -e "\e[96mVirtualBox not found\e[0m"
    dpkg-query --show  "qemu-kvm"
    if [ "$?" != "0" ];
    then
	echo -e "\e[96mKVM not found\e[0m"
	echo -e "\e[31mYou need to install KVM or VirtualBox Hypervisor before Minikube installation\e[0m"
        exit 1
    fi
fi

echo -e "\e[96mInstalling Minikube\e[0m"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

mkdir -p /usr/local/bin/
install minikube /usr/local/bin/
rm minikube
}



function installVSCode {
# https://code.visualstudio.com/docs/setup/linux
echo -e "\e[96mInstalling VS Code\e[0m"

snap install code --classic
}



function installVSCodeExtensions {
# Install vs code extension via terminal - https://code.visualstudio.com/docs/editor/extension-gallery#_command-line-extension-management
# How to run command as current user from script, runned with sudo - https://stackoverflow.com/questions/41366023/run-specific-command-without-sudo-inside-script-running-with-sudo-bash

echo -e "\e[96mInstalling VS Code extensions\e[0m"

#General extensions
echo -e "\t \e[96mInstalling Gitlens extension\e[0m"
sudo -u $SUDO_USER code --install-extension eamodio.gitlens

#Frontend extensions
echo -e "\t \e[96mInstalling TSLint extension\e[0m"
sudo -u $SUDO_USER code --install-extension ms-vscode.vscode-typescript-tslint-plugin

echo -e "\t \e[96mInstalling Prettier extension\e[0m"
sudo -u $SUDO_USER code --install-extension esbenp.prettier-vscode

echo -e "\t \e[96mInstalling Stylelint extension\e[0m"
sudo -u $SUDO_USER code --install-extension thibaudcolas.stylelint


#Backend extensions
echo -e "\t \e[96mInstalling C# extension\e[0m"
sudo -u $SUDO_USER code --install-extension ms-vscode.csharp

#Containers extensions
echo -e "\t \e[96mInstalling Docker extension\e[0m"
sudo -u $SUDO_USER code --install-extension ms-azuretools.vscode-docker

echo -e "\t \e[96mInstalling Kubernetes Snippets extension\e[0m"
sudo -u $SUDO_USER code --install-extension ipedrazas.kubernetes-snippets

echo -e "\t \e[96mInstalling Kubernetes Tools extension\e[0m"
sudo -u $SUDO_USER code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
}



apt-get update -q

installGit
installNETCoreSDK
installNodejs
installDockerCompose
installKubectl
installVSCode
installVSCodeExtensions

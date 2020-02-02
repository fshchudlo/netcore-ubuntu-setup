#!/bin/bash

function installGit {
#https://git-scm.com/download/linux
echo -e "\e[96mInstalling Git\e[0m"
apt-get install git -y
}



function installNETCoreSDK {
#https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-ubuntu-1904
echo -e "\e[96mInstalling .NET Core SDK\e[0m"

wget -q "https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

apt-get update
apt-get install apt-transport-https -y
apt-get update
apt-get install dotnet-sdk-3.1 -y
rm packages-microsoft-prod.deb

echo -e "\e[96mInstalling PowerShell Core\e[0m"
dotnet tool install --global PowerShell
}



function installNodejs {
# https://github.com/nodesource/distributions/blob/master/README.md#snapinstall
# In order to update to major versiob use:
#	snap refresh node --channel=14
echo -e "\e[96mInstalling Nodejs\e[0m"

snap install node --classic --channel=13
}



function installDockerCE {
#https://docs.docker.com/v17.09/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository
echo -e "\e[96mInstalling Docker CE\e[0m"

apt-get install apt-transport-https -y
apt-get install ca-certificates -y
apt-get install curl -y
apt-get install software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# For "eoan" distribution we need to change channel to "disco" - https://github.com/docker/for-linux/issues/833#issuecomment-544257796
DISTNAME=`lsb_release -cs`
if [[ $DISTNAME == "eoan" ]]
then
DISTNAME="disco"
fi

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $DISTNAME \
   stable"

apt-get update
apt-get install docker-ce -y
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



apt-get update

installGit
installNETCoreSDK
installNodejs
installDockerCE
installKubectl
installVSCode
installVSCodeExtensions

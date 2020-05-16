#!/bin/bash

function configureGitUserNameAndEmail() {
    echo -e "\e[96mEnter your git user name\e[0m"
    read GITUSERNAME
    sudo -u $SUDO_USER git config --global user.name $GITUSERNAME

    echo -e "\e[96mEnter your git user email\e[0m"
    read GITUSERMAIL
    sudo -u $SUDO_USER git config --global user.email $GITUSERMAIL
}

function configureGitDefaultEditor() {
    read -p $'\e[96mDo you want to set vscode as default git editor?(y/N)\e[0m' -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo -u $SUDO_USER git config --global core.editor "code --wait"
    fi
}

function configureGitCredentialStore() {
    read -p $'\e[96mDo you want to set libsecret as credential store?(y/N)\e[0m' -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then

        # https://www.softwaredeveloper.blog/git-credential-storage-libsecret
        # for ssh configuration see https://www.softwaredeveloper.blog/store-git-ssh-credentials-in-linux

        apt-get install libsecret-1-0 libsecret-1-dev -y
        cd /usr/share/doc/git/contrib/credential/libsecret
        make
        sudo -u $SUDO_USER git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
    fi
}

function configureDockerAccess() {
    # https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user
    sudo usermod -aG docker $SUDO_USER
    echo -e "\e[93mCurrent user configured to access docker socket\e[0m"
    echo -e "\e[93mYou need to restart computer before using docker\e[0m"
}

configureGitUserNameAndEmail
configureGitDefaultEditor
configureGitCredentialStore
configureDockerAccess

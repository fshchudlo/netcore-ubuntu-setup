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

function configureMinikubeDashboard() {
    echo -e "\e[96mRunning Minikube\e[0m"
    sudo -u $SUDO_USER minikube start
    echo -e "\e[96mInstalling Kubernetes Dashboard\e[0m"
    # https://github.com/kubernetes/dashboard
    sudo -u $SUDO_USER kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

    echo -e "\e[96mApplying admin-user and it's role mapping\e[0m"
    sudo -u $SUDO_USER kubectl apply -f minikube_admin_user.yaml
    sudo -u $SUDO_USER kubectl apply -f minikube_role_binding.yaml

    echo -e "\e[96mDashboard available at http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/\e[0m"
    echo
    echo -e "\e[96mIn order to use it you should run \"kubectl proxy\" command and access dashboard with a token printed by next command:\e[0m"
    echo -e "\e[92mkubectl -n kubernetes-dashboard describe secret \$(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print \$1}')\e[0m"
    echo
}

configureGitUserNameAndEmail
configureGitDefaultEditor
configureGitCredentialStore
configureMinikubeDashboard
configureDockerAccess

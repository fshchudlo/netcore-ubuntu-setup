#!/bin/bash

function configureMinikubeDashboard() {
    echo -e "\e[96mRunning Minikube\e[0m"
    sudo -u $SUDO_USER minikube start
    echo -e "\e[96mInstalling Kubernetes Dashboard\e[0m"
    # https://github.com/kubernetes/dashboard
    sudo -u $SUDO_USER kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

    echo -e "\e[96mApplying admin-user and it's role mapping\e[0m"
    echo
    sudo -u $SUDO_USER kubectl apply -f minikube_admin_user.yaml
    sudo -u $SUDO_USER kubectl apply -f minikube_role_binding.yaml
    echo
    echo -e "\e[96mDashboard available at http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/\e[0m"
    echo
    echo -e "\e[96mIn order to use it you should run \"kubectl proxy\" command and access dashboard with a token printed by next command:\e[0m"
    echo
    echo -e "\e[92mkubectl -n kubernetes-dashboard describe secret \$(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print \$1}')\e[0m"
    echo
    echo -e "\e[92mFor more details see https://github.com/kubernetes/dashboard#getting-started \e[0m"
    echo
}

configureMinikubeDashboard

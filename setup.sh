#!/bin/bash
###
# File: setup.sh
# File Created: 2023-01-06 11:14:56
# Usage : 
# Author: Benoit-Pierre STUDER
# -----
# HISTORY:
###

echo "Setting up prerequisites"

osName=$(hostnamectl | grep "Operating System" | awk -F": " {'print $2'})
echo "Detected OS : $osName"

echo "Installing Golang Role for Ansible"
ansible-galaxy install fubarhouse.golang

echo "Installing Oh-My-ZSH Role for Ansible"
ansible-galaxy install gantsign.oh-my-zsh

case $osName in
    *"Fedora"*)
        echo "Installing DNF-Automatic Role for Ansible"
        ansible-galaxy install exploide.dnf-automatic
        echo "Install customize-gnome Role for Ansible"
        ansible-galaxy install petermosmans.customize-gnome
    ;;

    "EndeavourOS"*|"Manjaro"*|"ArchLinux"*)
        echo "Installing Aur role for Ansible"
        ansible-galaxy collection install kewlfft.aur
    ;;

    "Pop!_OS"*)
        echo "Installing community.general collection"
        apt install -y -qq python3-apt
        ansible-galaxy install community.general
        # exit 0
    ;;

    *)
        echo "Unmanaged OS"
        exit 1
    ;;
esac

echo "Starting ansible playbook"
ansible-playbook main.yml -i inventory --ask-become-pass


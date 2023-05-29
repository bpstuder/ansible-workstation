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

desktopEnvironment=$(echo $XDG_CURRENT_DESKTOP)
echo "Detected Desktop Environment : $desktopEnvironment"
# echo "Installing Golang Role for Ansible"
# ansible-galaxy install fubarhouse.golang

echo "Installing Oh-My-ZSH Role for Ansible"
ansible-galaxy install gantsign.oh-my-zsh

echo "Install customize-gnome Role for Ansible"
ansible-galaxy install petermosmans.customize-gnome

case $osName in
    *"Fedora"*)
        echo "Installing DNF-Automatic Role for Ansible"
        ansible-galaxy install exploide.dnf-automatic

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


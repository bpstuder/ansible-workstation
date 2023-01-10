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

echo "Installing Golang Role for Ansible"
ansible-galaxy install fubarhouse.golang

echo "Installing Oh-My-ZSH Role for Ansible"
ansible-galaxy install gantsign.oh-my-zsh

echo "Installing DNF-Automatic Role for Ansible"
ansible-galaxy install exploide.dnf-automatic

echo "Starting ansible playbook"
ansible-playbook main.yml -i inventory --ask-become-pass


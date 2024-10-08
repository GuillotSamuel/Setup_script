#!/bin/bash

GITHUB_BASE_URL="https://raw.githubusercontent.com/GuillotSamuel/Setup_script/master"
source <(wget -qO - ${GITHUB_BASE_URL}/includes/include.sh)

sudo apt install -y git

echo -e "\n${CYAN}Git configuration:${RESET}\n"

read -p "Enter your Git username: " USER_NAME

read -p "Enter your Git email: " USER_EMAIL

sudo git config --global user.name "${USER_NAME}"
sudo git config --global user.email "${USER_EMAIL}"

echo -e "${GREEN}\nGit configuration completed:${RESET}"
echo "Username: ${USER_NAME}"
echo "Email: ${USER_EMAIL}"
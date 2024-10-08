#!/bin/bash

sudo apt install -y wget

GITHUB_BASE_URL="https://raw.githubusercontent.com/GuillotSamuel/Setup_script/master"
source <(wget -qO - ${GITHUB_BASE_URL}/includes/include.sh)

print_border() {
    echo -e "\n${MAGENTA}======================================${RESET}"
}

print_banner() {
    echo -e "\n${BLUE}          WELCOME TO YOUR SETUP       ${RESET}\n"
    print_border
}

print_banner
echo -e "${CYAN}Select an environment to set up:${RESET}"
print_border

echo -e "${GREEN}1) Manual Configuration${RESET}\n"
echo -e "${GREEN}2) Default Development Environment${RESET}\n"
echo -e "${GREEN}3) Default Development Environment for framework 13 amd${RESET}\n"
echo -e "${GREEN}4) Inception 42 project${RESET}\n"
echo -e "${GREEN}5) Camagru 42 project${RESET}\n"
echo -e "${RED}6) Exit${RESET}\n"
print_border

read -p "Enter your choice [1-6]: " choice

echo ""

case $choice in
    1)
        source <(wget -qO - ${GITHUB_BASE_URL}/installations/1_manual.sh)
        ;;
    2)
        source <(wget -qO - ${GITHUB_BASE_URL}/installations/2_default_dev.sh)
        ;;
    3)
        source <(wget -qO - ${GITHUB_BASE_URL}/installations/3_default_dev_fr13.sh)
        ;;
    4)
        source <(wget -qO - ${GITHUB_BASE_URL}/installations/4_inception.sh)
        ;;
    5)
        source <(wget -qO - ${GITHUB_BASE_URL}/installations/5_camagru.sh)
        ;;
    6)
        echo -e "${YELLOW}Exiting.${RESET}"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid choice. Please select a valid option.${RESET}"
        exit 1
        ;;
esac

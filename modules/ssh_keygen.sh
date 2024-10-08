#!/bin/bash

source ./includes/include.sh

echo -e "${CYAN}Génération clé SSH...${NC}"
sudo ssh-keygen -t rsa -b 4096 -C "samuelguillot75@gmail.com" -N "" -f ~/.ssh/id_rsa

echo -e "${GREEN}Clé SSH :${NC}"
echo -e "\n"
echo -e "\e[35m$(cat ~/.ssh/id_rsa.pub)\e[0m"
echo -e "\n"
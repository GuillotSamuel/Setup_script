#!/bin/bash

# Définir les couleurs
GREEN='\033[0;32m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
NC='\033[0m' # Pas de couleur

# Tableau pour stocker les résultats
declare -a results

# Fonction pour afficher OK ou KO en couleur
function check_status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}OK${NC}"
        results+=("${1}: ${GREEN}OK${NC}")
    else
        echo -e "${RED}KO${NC}"
        results+=("${1}: ${RED}KO${NC}")
    fi
}

# Mise à jour des paquets existants
echo -e "${ORANGE}Mise à jour des paquets existants...${NC}"
sudo apt update && sudo apt upgrade -y && sudo snap refresh
check_status "Mise à jour des paquets existants"

# MAJ Framework jack
echo -e "${ORANGE}Mise à jour du framework jack...${NC}"
echo 0 | sudo tee /sys/module/snd_hda_intel/parameters/power_save
check_status "MAJ Framework jack"

# Création des folders
echo -e "${ORANGE}Création des folders...${NC}"
mkdir -p ~/Travail/42 ~/Travail/Perso ~/Travail/Scripts

# Changement du mot de passe Root
echo -e "${ORANGE}Changement du mot de passe root...${NC}"
sudo passwd root

# Configuration du pare-feu
echo -e "${ORANGE}Configuration du pare-feu...${NC}"
sudo ufw allow OpenSSH
sudo ufw enable
check_status "Configuration du pare-feu"

# Configuration du fuseau horaire
echo -e "${ORANGE}Configuration du fuseau horaire...${NC}"
sudo timedatectl set-timezone Europe/Paris
check_status "Configuration du fuseau horaire"

# Configuration du SWAP
echo -e "${ORANGE}Configuration du SWAP...${NC}"
SWAPFILE="/swapfile"
if swapon --show | grep -q "$SWAPFILE"; then
    echo "Désactivation de l'ancien swap..."
    sudo swapoff "$SWAPFILE"
    sudo rm "$SWAPFILE"
else
    echo "Aucun swap existant trouvé."
fi
echo "Création d'un nouveau fichier de swap de 20 Go..."
sudo fallocate -l 20G "$SWAPFILE"
sudo chmod 600 "$SWAPFILE"
sudo mkswap "$SWAPFILE"
sudo swapon "$SWAPFILE"
if ! grep -q "$SWAPFILE" /etc/fstab; then
    echo "$SWAPFILE none swap sw 0 0" | sudo tee -a /etc/fstab > /dev/null
fi
check_status "Configuration du SWAP"

# Installation de Visual Studio Code
echo -e "${ORANGE}Installation de Visual Studio Code...${NC}"
sudo apt install -y software-properties-common apt-transport-https wget gpg

# Ajout de la clé de Microsoft pour le dépôt
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
rm packages.microsoft.gpg

# Ajout du dépôt de Visual Studio Code
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update

# Installation de Visual Studio Code
sudo apt install -y code
check_status "Installation de Visual Studio Code"

# Installer Snap
echo -e "${ORANGE}Installing Snap...${NC}"
sudo apt install -y snapd
check_status "Installation de Snap"

# Installer Flatpak
echo -e "${ORANGE}Installing Flatpak...${NC}"
sudo apt install -y flatpak
check_status "Installation de Flatpak"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
check_status "Configuration de Flathub pour Flatpak"

# Installer les outils pour C et C++
echo -e "${ORANGE}Installing C and C++ compilers...${NC}"
sudo apt install -y build-essential
check_status "Installation des compilateurs C et C++"

# Installer VLC
echo -e "${ORANGE}Installing VLC...${NC}"
sudo apt install -y vlc
check_status "Installation de VLC"

# Installer les outils pour Make
echo -e "${ORANGE}Installing Make tools...${NC}"
sudo apt install -y make cmake
check_status "Installation des outils Make"

# Installer Valgrind
echo -e "${ORANGE}Installing Valgrind...${NC}"
sudo apt install -y valgrind
check_status "Installation de Valgrind"

# Installer GDB
echo -e "${ORANGE}Installing GDB...${NC}"
sudo apt install -y gdb
check_status "Installation de GDB"

# Installer Python et pip
echo -e "${ORANGE}Installing Python and pip...${NC}"
sudo apt install -y python3 python3-pip
check_status "Installation de Python et pip"

# Installer Node.js et npm pour JavaScript
echo -e "${ORANGE}Installing Node.js and npm...${NC}"
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
check_status "Configuration du dépôt Node.js"
sudo apt install -y nodejs
check_status "Installation de Node.js et npm"

# Installer Docker
echo -e "${ORANGE}Installation de Docker...${NC}"
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
check_status "Installation de Docker"

# Installer Docker Compose
echo -e "${ORANGE}Installing Docker Compose...${NC}"
sudo apt install -y docker-compose
check_status "Installation de Docker Compose"

# Installer VirtualBox
echo -e "${ORANGE}Installing VirtualBox...${NC}"
sudo apt install -y virtualbox
check_status "Installation de VirtualBox"

# Installer Discord
echo -e "${ORANGE}Installing Discord...${NC}"
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
check_status "Téléchargement de Discord"
sudo apt install -y ./discord.deb
check_status "Installation de Discord"
rm discord.deb

# Installer tree
echo -e "${ORANGE}Installing tree...${NC}"
sudo apt install -y tree
check_status "Installation de tree"

# Installer PHP
echo -e "${ORANGE}Installing PHP...${NC}"
sudo apt install -y php
check_status "Installation de PHP"

# Installer Google Chrome
echo -e "${ORANGE}Installing Google Chrome...${NC}"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
check_status "Téléchargement de Google Chrome"
sudo apt install -y ./google-chrome-stable_current_amd64.deb
check_status "Installation de Google Chrome"
rm google-chrome-stable_current_amd64.deb

# Installer Vim
echo -e "${ORANGE}Installing Vim...${NC}"
sudo apt install -y vim
check_status "Installation de Vim"

# Installer Nano
echo -e "${ORANGE}Installing Nano...${NC}"
sudo apt install -y nano
check_status "Installation de Nano"

# Installer MySQL
echo -e "${ORANGE}Installing MySQL...${NC}"
sudo apt install -y mysql-server
check_status "Installation de MySQL"
sudo mysql_secure_installation
check_status "Sécurisation de MySQL"
sudo systemctl status mysql
check_status "Vérification du statut de MySQL"

# Installer MySQL Workbench
# echo -e "${ORANGE}Installing MySQL Workbench...${NC}"
# sudo apt install -y mysql-workbench
# check_status "Installation de MySQL Workbench"

# Installer Nginx
echo -e "${ORANGE}Installing Nginx...${NC}"
sudo apt install -y nginx
check_status "Installation de Nginx"

# Installer Zsh et Oh My Zsh
echo -e "${ORANGE}Installing Zsh and Oh My Zsh...${NC}"
sudo apt install -y zsh
check_status "Installation de Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
check_status "Installation de Oh My Zsh"
chsh -s $(which zsh)

# Mettre à jour tous les paquets et nettoyer
echo -e "${ORANGE}Updating all packages and cleaning up...${NC}"
sudo apt update && sudo apt upgrade -y
check_status "Mise à jour des paquets"
sudo apt autoremove -y
check_status "Suppression des paquets inutiles"
sudo apt autoclean
check_status "Nettoyage du cache des paquets"

# Git pour le contrôle de version
echo -e "${ORANGE}Installing Git...${NC}"
sudo apt install -y git
check_status "Installation de Git"

# Curl et wget
echo -e "${ORANGE}Installing Curl and Wget...${NC}"
sudo apt install -y curl wget
check_status "Installation de Curl et Wget"

# Postman
echo -e "${ORANGE}Installing Postman...${NC}"
sudo snap install postman
check_status "Installation de Postman"

# Htop
echo -e "${ORANGE}Installing htop...${NC}"
sudo apt install -y htop
check_status "Installation de htop"

# Installer Gparted
echo -e "${ORANGE}Installing Gparted...${NC}"
sudo apt install -y gparted
check_status "Installation de Gparted"

# Installer 7zip
echo -e "${ORANGE}Installing 7zip...${NC}"
sudo apt install -y p7zip-full p7zip-rar
check_status "Installation de 7zip"

# Installer Gnome extensions
echo -e "${ORANGE}Installing gnome-browser-connector...${NC}"
sudo apt-get install -y gnome-browser-connector
check_status "Installation de gnome-browser-connector"

echo -e "${ORANGE}Installing Nautilus...${NC}"
sudo apt install -y nautilus
check_status "Installation de Nautilus"

# Mettre à jour tous les paquets et nettoyer
echo "${ORANGE}Updating all packages and cleaning up...${NC}"
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean

# Configuration de Git
echo "${ORANGE}Configuration de Git...${NC}"
sudo git config --global user.name "Samuel_Guillot"
sudo git config --global user.email "samuelguillot75@gmail.com"

# Génération clé SSH
echo -e "${ORANGE}Génération clé SSH...${NC}"
sudo ssh-keygen -t rsa -b 4096 -C "samuelguillot75@gmail.com" -N "" -f ~/.ssh/id_rsa
check_status "Génération clé SSH"

# Fin des installations, affichage des résultats
echo -e "\n"
echo -e "${ORANGE}Résumé des installations :${NC}"
for result in "${results[@]}"; do
    echo -e "$result"
done

# Affichage de la clé ssh publique
echo -e "${ORANGE}Clé SSH :${NC}"
echo -e "\n"
echo -e "\e[35m$(cat ~/.ssh/id_rsa.pub)\e[0m"
echo -e "\n"

# Installation terminée !
echo -e "${GREEN}Installation complète !${NC} Redémarrez votre terminal ou votre machine si nécessaire."


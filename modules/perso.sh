# Création des folders
echo -e "${ORANGE}Création des folders...${NC}"
mkdir -p ~/Travail/42 ~/Travail/Perso ~/Travail/Scripts

# Changement du mot de passe Root
echo -e "${ORANGE}Changement du mot de passe root...${NC}"
sudo passwd root

# Configuration du fuseau horaire
echo -e "${ORANGE}Configuration du fuseau horaire...${NC}"
sudo timedatectl set-timezone Europe/Paris
check_status "Configuration du fuseau horaire"
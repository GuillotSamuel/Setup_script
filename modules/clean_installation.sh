echo -e "Updating all packages and cleaning up..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean
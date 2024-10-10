#!/bin/bash

GITHUB_BASE_URL="https://raw.githubusercontent.com/GuillotSamuel/Setup_script/master"
source <(wget -qO - ${GITHUB_BASE_URL}/includes/include.sh)

echo -e "${CYAN}Starting the default dev configuration...${RESET}"

# sudo apt update && sudo apt upgrade -y

modules_to_install=(
    "mariadb.sh"
    "nginx.sh"
    "docker.sh"
    "docker_compose.sh"
    "openssl.sh"
    "tree.sh"
    "clean_installation.sh"
)

# OTHER CUSTOM COMMANDS
# sudo usermod -aG sudo user
# echo "user ALL=(ALL:ALL) ALL" | sudo tee /etc/sudoers.d/user
# TO REMOVE FOR OTHER INSTALS

declare -A install_status

for script in "${modules_to_install[@]}"; do
    script_path="${GITHUB_BASE_URL}/modules/$script"

    echo "Script path: $script_path" # DEBUG

    wget -qO - "$script_path" | bash

    status=$?
    if [ $status -eq 0 ]; then
        install_status["$script"]="Success"
    else
        install_status["$script"]="Failed"
    fi
done

echo -e "\n${CYAN}Configuration Summary:${RESET}"
echo -e "${MAGENTA}=====================================${RESET}"
printf "%-30s | %s\n" "Module" "Status"
echo -e "${MAGENTA}=====================================${RESET}"

for script in "${modules_to_install[@]}"; do
    if [ "${install_status[$script]}" == "Success" ]; then
        echo -e "%-30s | %s\n" "${script}" "${GREEN}${install_status[$script]}${RESET}"
    else
        echo -e "%-30s | %s\n" "${script}" "${RED}${install_status[$script]}${RESET}"
    fi
done

echo -e "${MAGENTA}=====================================${RESET}"
echo -e "${GREEN}Inception configuration completed!${RESET}"

#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

echo -e "${GREEN}Success${RESET}"
echo -e "${RED}Failed${RESET}"

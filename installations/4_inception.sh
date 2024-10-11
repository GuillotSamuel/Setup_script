#!/bin/bash

GITHUB_BASE_URL="https://raw.githubusercontent.com/GuillotSamuel/Setup_script/master"
source <(wget -qO - ${GITHUB_BASE_URL}/includes/include.sh)

echo -e "${CYAN}Starting the default dev configuration...${RESET}"

# sudo apt update && sudo apt upgrade -y

modules_to_install=(
    "docker.sh"
    "docker_compose.sh"
    "tree.sh"
    "clean_installation.sh"
)

# OTHER CUSTOM COMMANDS
# sudo usermod -aG sudo user
# echo "user ALL=(ALL:ALL) ALL" | sudo tee /etc/sudoers.d/user
USER_NAME="user"
USER_PASSWORD="user"
DB_NAME="my_database"
DB_HOST="localhost"
ROOT_USER="root"
ROOT_PASSWORD="root_password"
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
printf "%-20s | %s\n" "Module" "Status"
echo -e "${MAGENTA}=====================================${RESET}"

for script in "${modules_to_install[@]}"; do
    if [ "${install_status[$script]}" == "Success" ]; then
        output="${install_status[$script]}"
    else
        output="${install_status[$script]}"
    fi
    printf "%-20s | %s\n" "${script}" ${output}
done

echo -e "${MAGENTA}=====================================${RESET}"
echo -e "${GREEN}Inception configuration completed!${RESET}"

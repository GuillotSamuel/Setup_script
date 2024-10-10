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
    script_path="../${MODULES}/$script"

    echo "Script path: $script_path"

    if [ -x "$script_path" ]; then
        echo -e "${GREEN}Running ${script}...${RESET}"
        bash "$script_path"
        status=$?

        if [ $status -eq 0 ]; then
            install_status["$script"]="${GREEN}Success${RESET}"
        else
            install_status["$script"]="${RED}Failed${RESET}"
        fi
    else
        echo -e "${YELLOW}Skipping ${script}: not executable.${RESET}"
        install_status["$script"]="${YELLOW}Skipped${RESET}"
    fi
done

echo -e "\n${CYAN}Configuration Summary:${RESET}"
echo -e "${MAGENTA}=====================================${RESET}"
printf "%-20s | %s\n" "Module" "Status"
echo -e "${MAGENTA}=====================================${RESET}"

for script in "${modules_to_install[@]}"; do
    printf "%-20s | %s\n" "${script}" "${install_status[$script]}"
done

echo -e "${MAGENTA}=====================================${RESET}"
echo -e "${GREEN}Inception configuration completed!${RESET}"

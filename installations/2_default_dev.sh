#!/bin/bash

GITHUB_BASE_URL="https://raw.githubusercontent.com/GuillotSamuel/Setup_script/master"
source <(wget -qO - ${GITHUB_BASE_URL}/includes/include.sh)

echo -e "${CYAN}Starting the default dev configuration...${RESET}"

sudo apt update && sudo apt upgrade -y

modules_to_install=(
    "perso.sh"
    "firewall.sh"
    "swap.sh"
    "vscode.sh"
    "snap.sh"
    "flatpack.sh"
    "c_cpp_tools.sh"
    "vlc.sh"
    "make_tools.sh"
    "valgrind.sh"
    "gdb.sh"
    "python_pip.sh"
    "nodejs_npm.sh"
    "docker.sh"
    "docker_compose.sh"
    "virtualbox.sh"
    "discord.sh"
    "tree.sh"
    "php.sh"
    "google_chrome.sh"
    "vim.sh"
    "nano.sh"
    "mysql.sh"
    "nginx.sh"
    "zsh_ohmyzsh.sh"
    "git.sh"
    "curl_wget.sh"
    "postman.sh"
    "htop.sh"
    "gparted.sh"
    "7zip.sh"
    "gnome_extension.sh"
    "nautilus.sh"
    "ssh_keygen.sh"
    "clean_installation.sh"
)

# OTHER CUSTOM COMMANDS
# [here...]
# TO REMOVE FOR OTHER INSTALS

declare -A install_status

for script in "${modules_to_install[@]}"; do
    script_path="$../{MODULES}/$script"

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

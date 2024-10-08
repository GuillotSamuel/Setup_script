GITHUB_BASE_URL="https://raw.githubusercontent.com/GuillotSamuel/Setup_script/master"
source <(wget -qO - ${GITHUB_BASE_URL}/includes/include.sh)

echo -e "${CYAN}SWAP configuration...${NC}"
SWAPFILE="/swapfile"

# Check if the user wants to configure swap
while true; do
    SIZE=$(zenity --entry --title="SWAP Size" --text="Enter swap size (e.g., 20G) or leave empty to skip:" --entry-text="20G")

    # Check if SIZE is not empty or if the user chooses to skip
    if [[ -z "$SIZE" ]]; then
        echo -e "${YELLOW}No size entered. Skipping SWAP configuration.${NC}"
        break  # Exit the loop if no size is provided
    else
        # Check if swap is already enabled
        if swapon --show | grep -q "$SWAPFILE"; then
            echo "Old swap deactivation..."
            sudo swapoff "$SWAPFILE"
            sudo rm "$SWAPFILE"
        else
            echo "No old swap found."
        fi

        # Proceed with creating swap
        echo "Creating a ${SIZE} file..."
        sudo fallocate -l "$SIZE" "$SWAPFILE"
        sudo chmod 600 "$SWAPFILE"
        sudo mkswap "$SWAPFILE"
        sudo swapon "$SWAPFILE"

        # Add to fstab if not already present
        if ! grep -q "$SWAPFILE" /etc/fstab; then
            echo "$SWAPFILE none swap sw 0 0" | sudo tee -a /etc/fstab > /dev/null
        fi

        echo -e "${GREEN}SWAP configuration completed!${NC}"
        break  # Exit the loop after completing SWAP configuration
    fi
done

GITHUB_BASE_URL="https://raw.githubusercontent.com/GuillotSamuel/Setup_script/master"
source <(wget -qO - ${GITHUB_BASE_URL}/includes/include.sh)

sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
for user in $(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd); do
    sudo usermod -aG docker "$user"
done
sudo usermod -aG docker $USER
sudo systemctl restart docker

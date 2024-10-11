GITHUB_BASE_URL="https://raw.githubusercontent.com/GuillotSamuel/Setup_script/master"
source <(wget -qO - ${GITHUB_BASE_URL}/includes/include.sh)

sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker user
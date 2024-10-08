sudo apt install -y apache2 php libapache2-mod-php php-mysql wget
sudo apt install -y mariadb-server

sudo mysql_secure_installation

read -p "Type database name [wordpress]: " DB_NAME
DB_NAME=${DB_NAME:-wordpress}

read -p "Type user name [wp_user]: " DB_USER
DB_USER=${DB_USER:-wp_user}

while true; do
    read -s -p "Type password for $DB_USER: " DB_PASS
    echo ""
    read -s -p "Confirm password: " DB_PASS_CONFIRM
    echo ""

    if [ "$DB_PASS" = "$DB_PASS_CONFIRM" ]; then
        break
    else
        echo "Passwords do not match. Please try again."
    fi
done

sudo mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE ${DB_NAME};
CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}'; # Remplacez 'your_password' par un mot de passe fort
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

sudo mv wordpress/* /var/www/html/

sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

cd /var/www/html/
cp wp-config-sample.php wp-config.php

sudo sed -i "s/database_name_here/${DB_NAME}/" wp-config.php
sudo sed -i "s/username_here/${DB_USER}/" wp-config.php
sudo sed -i "s/password_here/${DB_PASS}/" wp-config.php

sudo systemctl restart apache2

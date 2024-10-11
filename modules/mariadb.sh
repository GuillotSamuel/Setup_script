sudo apt install -y mariadb-server mariadb-client

sudo systemctl start mariadb
sudo systemctl status mariadb

sudo mysql --execute="UPDATE mysql.user SET Password=PASSWORD('${ROOT_PASSWORD}') WHERE User='${ROOT_USER}';"
sudo mysql --execute="FLUSH PRIVILEGES;"
sudo mysql --execute="DELETE FROM mysql.user WHERE User='';"
sudo mysql --execute="DROP DATABASE IF EXISTS test;"
sudo mysql --execute="FLUSH PRIVILEGES;"

sudo mysql --execute="CREATE USER '${USER_NAME}'@'${DB_HOST}' IDENTIFIED BY '${USER_PASSWORD}';"
sudo mysql --execute="GRANT ALL PRIVILEGES ON *.* TO '${USER_NAME}'@'${DB_HOST}' WITH GRANT OPTION;"
sudo mysql --execute="FLUSH PRIVILEGES;"
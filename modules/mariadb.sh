sudo apt install -y mariadb-server mariadb-client
sudo systemctl start mariadb
sudo systemctl status mariadb

sudo mysql --execute="UPDATE mysql.user SET Password=PASSWORD('user') WHERE User='root';"
sudo mysql --execute="FLUSH PRIVILEGES;"
sudo mysql --execute="DELETE FROM mysql.user WHERE User='';"
sudo mysql --execute="DROP DATABASE IF EXISTS test;"
sudo mysql --execute="FLUSH PRIVILEGES;"

sudo mysql --execute="CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';"
sudo mysql --execute="GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' WITH GRANT OPTION;"
sudo mysql --execute="FLUSH PRIVILEGES;"
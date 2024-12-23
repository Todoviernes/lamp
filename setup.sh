#!/bin/bash

# Update the package list
sudo apt update

# Upgrade the installed packages
sudo apt upgrade -y

# Install Apache Web Server
sudo apt install apache2 -y

# Adjust firewall to allow web traffic
sudo ufw allow in "Apache"
read -p "Firewall will be enabled. Do you want to continue? (y/n): " CONFIRM
if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
    sudo ufw enable
    echo "Firewall enabled."
else
    echo "Skipping firewall enablement."
fi

# Install MariaDB Server
sudo apt install mariadb-server -y

# Generate random secure passwords
ROOT_PASSWORD=$(openssl rand -base64 16)
DB_PASSWORD=$(openssl rand -base64 16)

# Save passwords securely to a temporary file
SECURE_PASSWORD_FILE="/tmp/secure_passwords.txt"
echo "Root Password: $ROOT_PASSWORD" > $SECURE_PASSWORD_FILE
echo "Database Password: $DB_PASSWORD" >> $SECURE_PASSWORD_FILE
chmod 600 $SECURE_PASSWORD_FILE

# Notify user about password storage
echo "Passwords have been securely stored in $SECURE_PASSWORD_FILE. Please move them to a safe location and delete this file after use."

# Secure MariaDB installation without manual input
sudo mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$ROOT_PASSWORD');"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DROP DATABASE IF EXISTS test;"
sudo mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Create a database and user for future WordPress setup
DB_NAME="wordpress_db"
DB_USER="wordpress_user"

sudo mysql -e "CREATE DATABASE $DB_NAME;"
sudo mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Install PHP and required extensions
sudo apt install php php-mysql libapache2-mod-php php-cli php-curl php-xml php-gd php-mbstring php-zip -y

# Enable Apache rewrite module
sudo a2enmod rewrite

# Final restart of Apache to load configurations
sudo systemctl restart apache2

# Final instructions
echo "LAMP stack setup complete. You can now install WordPress or another PHP application."
echo "Root Password for MariaDB: $ROOT_PASSWORD"
echo "Database Name: $DB_NAME"
echo "Database User: $DB_USER"
echo "Database Password: $DB_PASSWORD"

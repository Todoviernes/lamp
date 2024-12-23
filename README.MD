# LAMP Server Setup Script

## Overview
This script automates the setup of a LAMP (Linux, Apache, MariaDB, PHP) server on Ubuntu, preparing it for hosting applications like WordPress. The script includes installing necessary packages, configuring MariaDB securely, generating random secure passwords, and enabling PHP extensions.

## Features
- Installs and configures Apache, MariaDB, and PHP.
- Automatically secures MariaDB with random passwords.
- Configures a database and user for future application setups.
- Enables Apache's rewrite module.
- Provides clear instructions and password storage for enhanced security.

## Prerequisites
- A clean Ubuntu installation.
- Sudo privileges for the executing user.
- Internet access to download packages.

## How to Use
1. Download the script:
   ```bash
   wget https://example.com/install_lamp_wordpress.sh
   ```

2. Make the script executable:
   ```bash
   chmod +x install_lamp_wordpress.sh
   ```

3. Run the script:
   ```bash
   ./install_lamp_wordpress.sh
   ```

4. Follow any prompts during the script execution, especially for enabling the firewall.

5. After the script completes, the following information will be displayed:
   - Root Password for MariaDB
   - Database Name
   - Database User
   - Database Password

   These passwords are stored temporarily in `/tmp/secure_passwords.txt`. Move them to a safe location and delete the file.

## Output
The script provides the following:
- Installed and configured Apache, MariaDB, and PHP.
- A secure MariaDB root password.
- A database and user credentials for applications.

## Notes
- The script assumes a fresh Ubuntu environment and may overwrite existing configurations.
- MariaDB passwords are randomly generated and printed at the end of the script.
- Secure passwords are saved temporarily in `/tmp/secure_passwords.txt` with restricted permissions. Ensure to relocate and delete this file after use.

## Troubleshooting
- **Firewall Enablement**: If the script skips enabling the firewall, manually enable it using:
  ```bash
  sudo ufw enable
  ```
- **MariaDB Issues**: Verify the MariaDB service is running:
  ```bash
  sudo systemctl status mariadb
  ```
- **Apache Not Working**: Ensure Apache is active and running:
  ```bash
  sudo systemctl status apache2
  ```

## Customization
You can modify the following variables in the script to customize the setup:
- `DB_NAME`: Database name for your application.
- `DB_USER`: Database username.
- `DB_PASSWORD`: Randomly generated password for the database user.

## Disclaimer
Use this script at your own risk. Ensure you have backups of your data and configurations before running the script in a production environment.


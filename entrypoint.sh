#!/bin/bash

# Créer le dossier du socket MariaDB
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

# Démarrer MariaDB
service mariadb start

# Démarrer Apache
service apache2 start

# Créer base et utilisateur UNE SEULE FOIS
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER IF NOT EXISTS 'wp_user'@'localhost' IDENTIFIED BY 'wp_password';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'localhost';
FLUSH PRIVILEGES;
EOF

tail -f /var/log/apache2/access.log

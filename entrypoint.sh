#!/bin/bash

# Make sure INDEX environment variable is passed to Apache
INDEX=${INDEX:-1}
export INDEX

# Configure Apache to listen on port 8080 instead of 80
sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf

# Enable mod_dir to serve index.php as default
a2enmod dir 2>/dev/null

# Update DirectoryIndex to include index.php
sed -i 's/DirectoryIndex.*/DirectoryIndex index.php index.html/' /etc/apache2/mods-enabled/dir.conf

# Create Apache configuration to pass the environment variable to PHP
# Use SetEnv to set the variable with the actual value passed to the container
cat >> /etc/apache2/apache2.conf <<EOL

# Pass environment variables to CGI/PHP
SetEnv INDEX $INDEX
EOL

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
service mariadb start
service apache2 start
service nginx start

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'usertest'@'localhost' IDENTIFIED BY 'usertestpass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'usertest'@'localhost';
FLUSH PRIVILEGES;
EOF

# Keep container running and monitor logs
tail -f /var/log/nginx/access.log /var/log/apache2/access.log 2>/dev/null &
wait

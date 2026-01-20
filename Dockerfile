FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV INDEX=1

RUN apt update && apt install -y \
    apache2 \
    nginx \
    mariadb-server \
    php \
    php-mysql \
    php-mbstring \
    php-zip \
    php-gd \
    php-json \
    php-curl \
    wget \
    unzip \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Télécharger WordPress
RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && mv wordpress /var/www/html/ \
    && rm latest.zip

# Télécharger phpMyAdmin
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip \
    && unzip phpMyAdmin-latest-all-languages.zip \
    && mv phpMyAdmin-*-all-languages /var/www/html/phpmyadmin \
    && rm phpMyAdmin-latest-all-languages.zip

# Remove the default Apache index.html
RUN rm -f /var/www/html/index.html

# Generate self-signed SSL certificate for Nginx
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=State/L=City/O=Organization/CN=127.0.0.1"

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Copy index.php
COPY index.php /var/www/html/index.php

RUN chown -R www-data:www-data /var/www/html

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 443 8080

CMD ["/entrypoint.sh"]

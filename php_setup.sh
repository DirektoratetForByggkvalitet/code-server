#!/bin/bash

apt update && apt upgrade -y
apt install dialog ca-certificates apt-transport-https software-properties-common lsb-release -y
add-apt-repository ppa:ondrej/php -y && apt upgrade -y
apt install -y php8.2-{cli,curl,mysqlnd,gd,opcache,zip,intl,common,bcmath,imagick,xmlrpc,readline,memcached,redis,mbstring,apcu,xml,dom,memcache}
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm /tmp/composer-setup.php

exit 0
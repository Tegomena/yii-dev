FROM ubuntu:latest

RUN export DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y nginx curl git php-fpm php-cli php-mbstring mcrypt php-gd php-gd php-imagick php-intl php-memcache php-xml sqlite php-sqlite3 php-pgsql php-mysql mysql-server php-zip zip 
RUN ufw allow 'Nginx HTTP'



RUN apt-get -y  install apache2 libapache2-mod-php php php-mysql vim curl git php-mbstring php-xml php-gd zip php-zip
RUN service apache2 start
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN rm -Rf /root/.composer
RUN composer global require "fxp/composer-asset-plugin:~1.3"

CMD service apache2 start &&  tail -F /var/log/apache2/access.log

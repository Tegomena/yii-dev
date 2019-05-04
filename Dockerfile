FROM ubuntu:latest

RUN export DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y  install apache2 libapache2-mod-php php php-mysql vim curl git php-mbstring php-xml php-gd 
RUN service apache2 start
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN rm -Rf /root/.composer

RUN apt-get -y --fix-missing  install php-pear php-dev libcurl3-openssl-dev
RUN printf "\n" | pecl install swoole
RUN echo "extension=swoole.so" >> /etc/php/7.2/cli/php.ini
RUN echo "extension=swoole.so" >> /etc/php/7.2/apache2/php.ini
ADD swoole-example.php /usr/local/bin

CMD service apache2 start &&  tail -F /var/log/apache2/access.log

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

CMD service apache2 start &&  tail -F /var/log/apache2/access.log

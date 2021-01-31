FROM alpine:latest

LABEL "Maintaner"="lturbang@student.s19.be"

#install & update
RUN apk add openrc --no-cache
RUN apk update
RUN apk upgrade
RUN apk add apache2 php7-apache2  php7 php-mysqli php7-fpm php7-json php-mbstring php-iconv php-gettext php7-session
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Setup server file & perms
RUN addgroup -g 1000 -S apache2 && \
	adduser -S -D -H -u 1000 -h /etc/apache2/ -s /sbin/nologin -G apache2 apache2 && \
	chown -R apache2:apache2 /etc/apache2 && \
	chown -R apache2:apache2 /var/www/ && \
	chown -R apache2:apache2 /var/log/apache2 && \
	chown -R apache2:apache2 /run/apache2
RUN mkdir -p /run/openrc/ && touch /run/openrc/softlevel

# TELEGRAF
RUN mkdir /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

# CONFIG PhpMyAdmin
ADD https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz  .
RUN rm -f /var/www/localhost/htdocs/index.html
RUN tar xzf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components=1 -C /var/www/localhost/htdocs/.
RUN rm -f phpMyAdmin-4.9.0.1-all-languages.tar.gz
ADD ./srcs/config.inc.php var/www/localhost/htdocs/config.inc.php
RUN echo "<?php phpinfo(); ?>" > /var/www/localhost/htdocs/info.php
RUN chown -R apache2:apache2 /var/www/

EXPOSE 80

# Copy and start 'start.sh'
COPY srcs/start.sh ./start.sh
RUN chmod 777 start.sh
CMD sh ./start.sh
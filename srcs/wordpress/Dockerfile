FROM alpine:latest

LABEL "Maintaner"="lturbang@student.s19.be"

#install & update
RUN apk add openrc --no-cache
RUN apk update
RUN apk upgrade
RUN apk add apache2 php7-apache2  php7 php-mysqli php7-fpm php7-json
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Setup server file & perms
RUN addgroup -g 1000 -S apache2 && \
	adduser -S -D -H -u 1000 -h /etc/apache2/ -s /sbin/nologin -G apache2 apache2 && \
	chown -R apache2:apache2 /etc/apache2 && \
	chown -R apache2:apache2 /var/www/ && \
	chown -R apache2:apache2 /var/log/apache2 && \
	chown -R apache2:apache2 /run/apache2
RUN mkdir -p /run/openrc/ && touch /run/openrc/softlevel

#TELEGRAF
RUN mkdir /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

# CONFIG WORDPRESS
RUN rm -f /var/www/localhost/htdocs/index.html
ADD ./srcs/wordpress/. /var/www/localhost/htdocs/.
ADD ./srcs/wp-config.php ./var/www/localhost/htdocs/wp-config.php
RUN echo "<?php phpinfo(); ?>" > /var/www/localhost/htdocs/info.php
RUN chown -R apache2:apache2 /var/www/

EXPOSE 80

# Copy and start 'start.sh'
COPY srcs/start.sh ./start.sh
RUN chmod 777 start.sh
CMD sh ./start.sh
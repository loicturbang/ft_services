FROM alpine:latest

LABEL "Maintaner"="lturbang@student.s19.be"

#install & update
RUN apk add openrc --no-cache
RUN apk update
RUN apk upgrade
RUN apk add nginx openssl openssh
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Telegraf
RUN mkdir /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

# Create web server user
RUN adduser -D -g 'www' www;

# Setup server file & perms
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN mkdir -p /run/nginx

# Config Nginx and add index page
COPY srcs/index.html /www/index.html
COPY srcs/nginx.conf /etc/nginx/nginx.conf

#CONFIG SSL
RUN adduser -D user
RUN echo "user:password" | chpasswd
RUN mkdir /etc/nginx/ssl
RUN ssh-keygen -A
RUN echo "Welcome to Nginx server via SSH (powered by lturbang)" > /etc/motd
RUN openssl req -x509 -nodes -days 365 -subj "/C=BE/ST=Waterloo/O=19/OU=lturbang/CN=www.localhost" -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

EXPOSE 22
EXPOSE 80
EXPOSE 443

# Copy and start 'start.sh'
COPY srcs/start.sh ./start.sh
RUN chmod 777 start.sh
CMD sh ./start.sh
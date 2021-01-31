FROM alpine:latest

LABEL "Maintaner"="lturbang@student.s19.be"

#install & update
RUN apk add openrc --no-cache
RUN apk update
RUN apk upgrade
RUN apk add mysql mysql-client
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Config mysql
RUN mkdir app
RUN mkdir -p /run/mysqld && touch /run/mysqld/mysqld.sock
COPY ./srcs/mysql.cnf /etc/mysql/my.cnf
COPY ./srcs/init.sql ./init.sql
RUN mkdir -p /run/openrc/ && touch /run/openrc/softlevel

#TELEGRAF
RUN mkdir /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 3306

COPY srcs/start.sh ./start.sh
RUN chmod 777 start.sh
CMD sh ./start.sh
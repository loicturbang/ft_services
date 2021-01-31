FROM alpine:latest

LABEL "Maintaner"="lturbang@student.s19.be"

#install & update
RUN apk add openrc --no-cache
RUN apk update && apk upgrade
RUN apk add influxdb
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Telegraf
RUN mkdir /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 8086

COPY srcs/start.sh ./start.sh
RUN chmod 777 start.sh
CMD sh ./start.sh
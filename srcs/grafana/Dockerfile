FROM alpine:latest

LABEL "Maintaner"="lturbang@student.s19.be"

#install & update
RUN apk add openrc --no-cache
RUN apk update && apk upgrade
RUN apk add telegraf grafana --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Telegraf
RUN mkdir /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

# GRAFANA DASHBOARD .DB /usr/share/grafana/data/grafana.db    ------------    #user admin   ||||  password grafana
COPY ./srcs/grafana.db /usr/share/grafana/data/grafana.db

EXPOSE 3000

COPY srcs/start.sh ./start.sh
RUN chmod 777 start.sh
CMD sh ./start.sh
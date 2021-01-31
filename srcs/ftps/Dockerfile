FROM alpine:latest

LABEL "Maintaner"="lturbang@student.s19.be"

#install & update
RUN apk add openrc --no-cache
RUN apk update
RUN apk upgrade
RUN apk add openssl pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

RUN mkdir -p /etc/ssl/private
RUN openssl req -x509 -nodes -days 7300 -subj "/C=BE/ST=Waterloo/O=19/OU=lturbang" -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem

RUN chmod 600 /etc/ssl/private/pure-ftpd.pem
RUN mkdir -p /run/openrc/ && touch /run/openrc/softlevel

# TELEGRAF
RUN mkdir /etc/telegraf
COPY ./srcs/telegraf.conf /etc/telegraf/telegraf.conf

#FTP USER
RUN adduser -D lturbang
RUN echo "lturbang:lturbang" | chpasswd
RUN touch /home/lturbang/test.txt

EXPOSE 21

COPY srcs/start.sh ./start.sh
RUN chmod 777 start.sh
CMD sh ./start.sh
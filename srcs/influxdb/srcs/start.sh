#!/bin/sh

# Start influxdb and keep container running
(telegraf conf &) && influxd run -config /etc/influxdb.conf
tail -f /dev/null
#!/bin/sh

# Start grafana and keep container running
(telegraf conf &) && grafana-server --homepath "/usr/share/grafana" start
tail -f /dev/null
#!/bin/sh

# Start ftps and keep container running
(telegraf conf &) && /usr/sbin/pure-ftpd -Y 2 -p 30000:30009 -P 172.17.0.242
tail -f /dev/null
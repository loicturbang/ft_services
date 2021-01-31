#!/bin/sh

# Start nginx and ssh
/usr/sbin/sshd && (telegraf conf &) && nginx -g "daemon off;"
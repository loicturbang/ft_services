#!/bin/sh

(telegraf conf &) && httpd -D FOREGROUND
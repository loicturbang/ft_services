#!/bin/sh

# First install mysql
if [ ! -d /app/mysql/mysql ]
then
    echo Creating initial database...
    mysql_install_db --user=root > /dev/null
    echo Done!
fi

# Add wordpress db user
if ! /usr/bin/mysqld --user=root --bootstrap --verbose=0 < init.sql
then
    echo Cannot bootstrap mysql!
    exit 1
fi

# Start telegraf and mysql
(telegraf conf &) && mysqld --user=root --console
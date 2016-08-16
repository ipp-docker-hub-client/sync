#!/bin/bash

chmod -R 2775 /data
chown -R root:btsync /data

chown -R root:www-data /data/www-data/
usermod -a -G www-data btsync

chown -R root:mysql /data/mysql/
usermod -a -G mysql btsync

start="/usr/bin/btsync --config /var/btsync/sync.conf"
su -c "$start" -s /bin/sh btsync



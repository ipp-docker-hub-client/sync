#!/bin/bash

chmod -R 755 /var/btsync
chown -R btsync:btsync /var/btsync

if [ -d "/data" ]; then
  chmod -R 775 /data
  chown -R 0:0 /data
  chmod g+s /data
  chown -R 0:33 /data/www-data/
  setfacl -d -m g::rwx /data/www-data/
  chown -R 0:105 /data/mysql/
  setfacl -d -m g::rwx /data/mysql/
fi

#start="/usr/bin/btsync --config /var/btsync/sync.conf --nodaemon"
#su -c "$start" -s /bin/sh btsync

/usr/bin/btsync --config /var/btsync/sync.conf --nodaemon

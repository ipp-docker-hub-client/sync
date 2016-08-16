#!/bin/bash

chmod -R 775 /var/btsync
chown -R root:btsync /var/btsync

if [ -d "/data/www-data/" ]; then
  chmod -R 2775 /data
  chown -R root:btsync /data

  chown -R 0:33 www-data/
  usermod -a -G www-data btsync

  chown -R 0:105 /data/mysql/
  usermod -a -G mysql btsync
fi

#start="/usr/bin/btsync --config /var/btsync/sync.conf"
#su -c "$start" -s /bin/sh btsync

bash /usr/bin/btsync --config /var/btsync/sync.conf

#!/bin/bash

if [ -d "/data" ]; then
  chmod -R 6775 /data
  chown -R 0:0 /data
  chown -R 33:0 /data/www-data/
  chown -R 105:0 /data/mysql/
fi

/usr/bin/btsync --config /var/btsync/sync.conf --nodaemon

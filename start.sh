#!/bin/bash

if [ -d "/data" ]; then
  chmod -R 775 /data
  chown -R 0:0 /data
fi

/usr/bin/btsync --config /var/btsync/sync.conf --nodaemon

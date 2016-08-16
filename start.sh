chmod 2775 /data
chown root:btsync /data

chown root:www-data /data/www-data/
usermod -a -G www-data btsync

chown root:mysql /data/mysql/
usermod -a -G mysql btsync

/usr/bin/btsync --config /var/btsync/sync.conf

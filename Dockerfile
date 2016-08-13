FROM ubuntu:16.04
MAINTAINER MOHSEN

RUN apt-get update; apt-get install -q -y git wget sed
RUN echo "deb http://linux-packages.getsync.com/btsync/deb btsync non-free" > /etc/apt/sources.list.d/btsync.list
RUN wget -qO - http://linux-packages.getsync.com/btsync/key.asc | apt-key add -
RUN apt-get update; apt-get install -q -y btsync
RUN mkdir -p /var/btsync/

# Print out the version (there is no version arg, so we grep for it)
RUN /usr/bin/btsync --foobar | grep "BitTorrent Sync"

RUN bash check.sh
RUN sed -i "s/HOSTNAME/$(DOCKERCLOUD_CONTAINER_HOSTNAME)/g;s/DOCKERID/$(DOCKERCLOUD_CONTAINER_FQDN)/g;" sync.conf

# Add config file
ADD sync.conf /var/btsync/sync.conf

ENTRYPOINT ["btsync"]
CMD ["--config", "/var/btsync/sync.conf", "--nodaemon"]

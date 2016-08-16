FROM ubuntu:16.04
MAINTAINER MOHSEN

ENV NR_INSTALL_SILENT true
ENV DEBIAN_FRONTEND noninteractive
ADD . /var/btsync/
WORKDIR /var/btsync/

RUN apt-get update; apt-get install -q -y git wget
RUN echo "deb http://linux-packages.getsync.com/btsync/deb btsync non-free" > /etc/apt/sources.list.d/btsync.list
RUN wget -qO - http://linux-packages.getsync.com/btsync/key.asc | apt-key add -
RUN apt-get update; apt-get install -q -y btsync
RUN apt-get remove -q -y git wget; apt-get -q -y clean

RUN /usr/bin/btsync --help | grep "BitTorrent Sync" #log version info
RUN sed -i "s/HOSTNAME/$DOCKERCLOUD_CONTAINER_HOSTNAME/g;s/DOCKERID/$DOCKERCLOUD_CONTAINER_FQDN/g;" /var/btsync/sync.conf
RUN bash wrapper.sh 5 /usr/bin/btsync --config /var/btsync/sync.conf --nodaemon

ENTRYPOINT ["/var/btsync/start.sh"]

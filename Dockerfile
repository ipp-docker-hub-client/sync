FROM ubuntu:16.04
MAINTAINER MOHSEN

ENV NR_INSTALL_SILENT true
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update; apt-get install -q -y git wget
RUN echo "deb http://linux-packages.getsync.com/btsync/deb btsync non-free" > /etc/apt/sources.list.d/btsync.list
RUN wget -qO - http://linux-packages.getsync.com/btsync/key.asc | apt-key add -
RUN apt-get update; apt-get install -q -y btsync
RUN apt-get -q -y clean

ADD sync.cnf /var/btsync/sync.conf
RUN /usr/bin/btsync --foobar | grep "BitTorrent Sync"

WORKDIR /var/btsync/
RUN sed -i "s/HOSTNAME/$(DOCKERCLOUD_CONTAINER_HOSTNAME)/g;s/DOCKERID/$(DOCKERCLOUD_CONTAINER_FQDN)/g;" sync.conf
#RUN timeout -sHUP 10s /usr/bin/btsync --config sync.conf --nodaemon

ENTRYPOINT ["btsync"]
CMD ["--config", "sync.conf", "--nodaemon"]

FROM node:6.3.1
MAINTAINER Scott Justason <scott.justason@gmail.com>

RUN apt-get update; \
apt-get install -y apt-utils apt-transport-https; \
apt-get upgrade -y; \
apt-get install -y locales curl wget; \
apt-get install -y libnss-mdns avahi-discover libavahi-compat-libdnssd-dev libkrb5-dev; \
apt-get install -y nano vim

RUN npm install -g homebridge
RUN npm install -g homebridge-platform-wemo

USER root
RUN mkdir -p /var/run/dbus

ADD start.sh /root/start.sh

VOLUME /root/.homebridge
EXPOSE 5353 51826
CMD ["/root/start.sh"]

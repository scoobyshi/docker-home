FROM node:6.3.1
MAINTAINER Scott Justason <scott.justason@gmail.com>

RUN apt-get update; \
apt-get install -y apt-utils apt-transport-https; \
apt-get upgrade -y; \
apt-get install -y locales curl wget; \
apt-get install -y libnss-mdns avahi-discover libavahi-compat-libdnssd-dev libkrb5-dev; \
apt-get install -y nano vim sudo

RUN npm install -g homebridge
RUN npm install -g homebridge-platform-wemo

USER root
RUN mkdir -p /var/run/dbus

RUN useradd --user-group --create-home --shell /bin/false app
ENV HOME=/home/app
RUN echo "app ALL=(root) NOPASSWD: /usr/bin/dbus-daemon\n"\
"app ALL=(root) NOPASSWD: /usr/sbin/avahi-daemon\n"\
"app ALL=(root) NOPASSWD: /usr/sbin/service dbus start\n"\
"app ALL=(root) NOPASSWD: /usr/sbin/service avahi-daemon start" >> /etc/sudoers

ADD start.sh /home/app/start.sh
RUN chown -R app:app $HOME/*
USER app

VOLUME /home/app/.homebridge
EXPOSE 5353 51826
CMD ["/home/app/start.sh"]

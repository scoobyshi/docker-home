#!/bin/bash

sudo dbus-daemon --system
sudo avahi-daemon -D

sudo service dbus start
sudo service avahi-daemon start

echo $HOME
homebridge

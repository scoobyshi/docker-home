#!/bin/bash

dbus-daemon --system
avahi-daemon -D

service dbus start
service avahi-daemon start

homebridge

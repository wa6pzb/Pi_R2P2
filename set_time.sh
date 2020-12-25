#!/bin/bash


# https://wb4son.com/wpblog/?p=1635

sudo gpsd /dev/serial0 -F /var/run/gpsd.sock
./gps_settime.py

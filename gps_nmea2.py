#! /usr/bin/python

# https://ozzmaker.com/using-python-with-a-gps-receiver-on-a-raspberry-pi/


import serial
import pynmea2

port = "/dev/serial0"


def parseGPS(str):
    if str.find('GGA') > 0:
        msg = pynmea2.parse(str)
        #print "Timestamp: %s -- Lat: %s %s -- Lon: %s %s -- Altitude: %s %s -- Satellites: %s" % (msg.timestamp,msg.lat,msg.lat_dir,msg.lon,msg.lon_dir,msg.altitude,msg.altitude_units,msg.num_sats)
        print "%s %s %s %s" % (msg.latitude,msg.longitude,msg.altitude,msg.num_sats)

serialPort = serial.Serial(port, baudrate = 9600, timeout = 0.5)
while (type <> 3) :
    str = serialPort.readline()
    #count = count + 1
    parseGPS(str)
    type = str.find('GGA')
    # print type

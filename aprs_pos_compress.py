#!/usr/bin/env python

# WA6PZB - 12/14/2020
#
# APRS Compressed Position Script
# Calculate the Base91 Lat/Long (8 characters)
# Base91 calculation base on the method here - http://tt7hab.blogspot.com/2017/02/

lat = 33.779807      # 49.4913
long = -118.0383     # 18.2232

temp = (90 - lat) * 380926
temp2 = temp / 753571  # First base91 lat code

rem1 = temp % 753571
temp3 = rem1 / 8281 # second base91 lat code
rem2 = rem1 % 8281
temp4 =rem2 / 91    # third base91 lat code
rem3 = rem2 % 91
temp5 = rem3        # fourth base91 lat code

long_temp = (180 + long) * 190463
long_temp2 = long_temp / 753571   # first base91 long code

long_rem1 = long_temp % 753571
long_temp3 = long_rem1 / 8281   # second base91 long code
long_rem2 = long_rem1 % 8281
long_temp4 = long_rem2 /91      # third base91 code
long_rem3 = long_rem2 % 91
long_temp5 = long_rem3          # fourth base91 code



print "Lat --> ", lat, int(temp2), int(temp3), int(temp4), int(temp5)
print "Long --> ", long,int(long_temp2), int(long_temp3), int(long_temp4), int(long_temp5)

print chr(int(temp2 + 33)) + chr(int(temp3 + 33)) + chr(int(temp4 + 33)) + chr(int(temp5 + 33))
print chr(int(long_temp2) + 33) + chr(int(long_temp3) + 33) + chr(int(long_temp4 + 33)) + chr(int(long_temp5 +33))

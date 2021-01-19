#!/bin/bash

#
# WA6PZB 11/22/2020
#
# Script to TX APRS data
# Using the utilities:
#       gen_packets - convert text to APRS audio WAV files
#       PiFmAdv_APRS     - Transmit FM RF using wave file (modified version by KA9CQL)
#
# 12/27/2020 - Added freq, call, path, pos, and sym varibles
# 12/28/2020 - Added compressed packet example

delay=30

freq=144.34

call="WA6PZB-11"

path=">BEACON,WIDE2-1:"

pos="!3346.79N/11802.34W"

sym="OH"

#compress="!/=G,c0]+mON3W |!$1B<m,%1E!(!$|"
#compress="!/=G,c0]+mON3W_http://wa6pzb.com/|"
#compress='!/=G,c0]+mO!)W_|"*.T.T.T.T.T!0|'
compress='!/=G,c0]+mO!)W_'


PiFmAdv_APRS="/home/pi/PiFmAdv_APRS/src/"
Direwolf="/home/pi/direwolf/scripts/telemetry-toolkit/"

counter=1

while [ true ]

do

        #*** POSITION ***

        # Delete the packet and WAV files every time
        rm aprs_packet.txt
        rm out.wav

        # Need the  message twice in the file for it to work
        echo -e ${call}${path}${pos}${sym}${counter} >> aprs_packet.txt
        echo -e ${call}${path}${pos}${sym}${counter} >> aprs_packet.txt

        # Generate WAV file
        gen_packets -o out.wav aprs_packet.txt

        # Transmit the WAV file on FM RF
        #sudo $PiFmAdv_APRS/pi_fm_adv --audio out.wav --freq $freq --dev 12.5 --cutoff 100000 --rds 0 -P 5000 --tp 0

        echo -e "...sleeping for "$delay" seconds"
        sleep $delay


        #*** Telemetry ***


        # Delete the packet and WAV files every time
        rm aprs_packet.txt
        rm out.wav

        # Need the  message twice in the file for it to work
        echo -e $call'>BEACON,WIDE2-1:T#'$counter',199,000,255,073,123,01101001' >> aprs_packet.txt
        echo -e $call'>BEACON,WIDE2-1:T#'$counter',199,000,255,073,123,01101001' >> aprs_packet.txt

        # Generate WAV file
        gen_packets -o out.wav aprs_packet.txt

        # Transmit the WAV file on FM RF
        #sudo $PiFmAdv_APRS/pi_fm_adv --audio out.wav --freq $freq --dev 12.5 --cutoff 100000 --rds 0 -P 5000 --tp 0

        echo -e "...sleeping for "$delay" seconds"
        sleep $delay


        # Compressed Position/Telemetry


        # Delete the packet and WAV files every time
        rm aprs_packet.txt
        rm out.wav

        # Need the  message twice in the file for it to work
        telem=$($Direwolf/telem-data91.pl ${counter} 4321 1234 1234 1234 1234 11110000)
        echo -e $call'>BEACON,WIDE2-1:'$compress$telem >> aprs_packet.txt
        echo -e $call'>BEACON,WIDE2-1:'$compress$telem >> aprs_packet.txt

        # Generate WAV file
        gen_packets -o out.wav aprs_packet.txt

        # Transmit the WAV file on FM RF
        sudo $PiFmAdv_APRS/pi_fm_adv --audio out.wav --freq $freq --dev 12.5 --cutoff 100000 --rds 0 -P 5000 --tp 0




((counter++))

echo -e "...sleeping for "$delay" seconds"
sleep $delay

done

echo exiting...

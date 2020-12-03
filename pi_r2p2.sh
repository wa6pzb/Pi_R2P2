#!/bin/bash

#
# WA6PZB 11/22/2020
#
# Script to TX APRS data
# Using the utilities:
#       gen_packets - convert text to APRS audio WAV files
#       PiFmAdv_APRS     - Transmit FM RF using wave file (modified version by KA9CQL)
#
#

PiFmAdv_APRS="/home/pi/PiFmAdv_APRS/src/"
counter=1

while [ true ]

do

        #*** POSITION ***

        # Delete the packet and WAV files every time
        rm aprs_packet.txt
        rm out.wav

        # Need the  message twice in the file for it to work
        echo -e 'WA6PZB-11>BEACON,WIDE2-1:!3346.79N/11802.34WOH'$counter >> aprs_packet.txt
        echo -e 'WA6PZB-11>BEACON,WIDE2-1:!3346.79N/11802.32WOH'$counter >> aprs_packet.txt

        # Generate WAV file
        gen_packets -o out.wav aprs_packet.txt

        # Transmit the WAV file on FM RF
        sudo $PiFmAdv_APRS/pi_fm_adv --audio out.wav --freq 144.39 --dev 12.5 --cutoff 100000 --rds 0 -P 5000 --tp 0

        echo -e "...sleeping for 3 minutes"
        sleep 60


        #*** Telemetry ***


        # Delete the packet and WAV files every time
        rm aprs_packet.txt
        rm out.wav

        # Need the  message twice in the file for it to work
        echo -e 'WA6PZB-11>BEACON,WIDE2-1:T#'$counter',199,000,255,073,123,01101001' >> aprs_packet.txt
        echo -e 'WA6PZB-11>BEACON,WIDE2-1:T#'$counter',199,000,255,073,123,01101001' >> aprs_packet.txt

        # Generate WAV file
        gen_packets -o out.wav aprs_packet.txt

        # Transmit the WAV file on FM RF
        sudo $PiFmAdv_APRS/pi_fm_adv --audio out.wav --freq 144.39 --dev 12.5 --cutoff 100000 --rds 0 -P 5000 --tp 0



((counter++))

echo -e "...sleeping for 1 min"
sleep 60

done

echo exiting...

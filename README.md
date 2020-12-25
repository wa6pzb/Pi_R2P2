# Pi_R2P2
Pi Repeatable Retrievable Payload Package (R2P2)

Pi_R2P2 is a Raspberry Pi based High Alititude Balloon (HAB) Payload consisting of a Raspberry Pi Zero, GPS module and battery pack. 

Pi_R2P2 is dependent on these other software packages:

Direwolf - gen_packets - convert text to APRS audio WAV files
PiFmAdv Fork - PiFmAdv_APRS     - Transmit FM RF using wave file (modified version by KA9CQL)
RPiTX - HF Transmit - SSTV & FT8
gpsd - GPS tools
Python - pySerial, pyNMEA

The basic cabilities include:

Send postion and telemetry packets via APRS every minute

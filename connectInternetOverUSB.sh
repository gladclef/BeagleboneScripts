#!/bin/bash

__BEAGLEBONE_SCRIPTS_CONNECT_TO_INTERNET()
{
	echo "Checking for internet connection"

	PING_RESULTS=$( ping -c 1 8.8.8.8 2>&1 );
	if [ "$PING_RESULTS" = "connect: Network is unreachable" ]
	then
	        if [ "$#" -ne 1 ]
	        then
	                echo "ping failed, setting up internet connection"
	                route add default gw 192.168.7.1
	                $0 "attempt 2"
	        else
	                echo "could not connect to network"
	        fi
	else
	        echo "we have internet over USB!"
	        if [ "$#" -eq 1 ]
	        then
	                echo "update date and time"
	                ntpdate -b -s -u ie.pool.ntp.org
	        fi
	fi
}

echo "Check for internet connection (y/n)? "
read -n 1 ANSWER
if [[ $ANSWER == "y" ]]
then
	__BEAGLEBONE_SCRIPTS_CONNECT_TO_INTERNET
else
	echo ""
fi

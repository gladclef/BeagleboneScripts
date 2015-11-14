#!/bin/bash

__BEAGLEBONE_SCRIPTS_CONNECT_TO_INTERNET()
{
	PING_RESULTS=$( ping -c 1 8.8.8.8 2>&1 );
	if [ "$?" -ne 0 ]
	then
	        if [ "$#" -ne 1 ]
	        then
	                echo "ping failed, setting up internet connection"
	                route add default gw 192.168.7.1
			CMD="__BEAGLEBONE_SCRIPTS_CONNECT_TO_INTERNET attempt2"
			eval "$CMD"
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

read -n 1 -t 3 -p "Check for internet connection (y/n)? " ANSWER
SUCCESS=$?
echo ""
if [ $SUCCESS -eq 0 ]
then
	if [[ $ANSWER == "y" ]]
	then
		echo "Checking for internet connection"
		__BEAGLEBONE_SCRIPTS_CONNECT_TO_INTERNET
	fi
else
	echo "timed out after 3 seconds"
fi

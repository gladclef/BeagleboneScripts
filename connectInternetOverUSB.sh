#!/bin/bash

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

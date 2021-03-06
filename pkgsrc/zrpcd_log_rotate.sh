#!/bin/bash

LOGFILE="/opt/quagga/var/log/quagga/zrpcd.init.log"

while [ "1" ]
do
    	#After every 30 miniute and run logrotate
	if [ $# -lt 2 ]
	then
		echo "Please input: timeout size"
		echo "timeout is how long to sleep then to check"
		echo "size is how large the logfile when begin rotate"
		exit
	fi
	time_sleep=${1}
	size=${2}
	#echo "argc=$#, time_sleep=${time_sleep}, check_size=${size}"
	sleep $time_sleep
	if [ -r $LOGFILE ] && [ "$(stat --printf='%s' $LOGFILE)" -gt "$((${size}*1024*1024))" ]; then
		/usr/sbin/logrotate -f /opt/quagga/etc/init.d/zrpcd.rotate
	fi
done


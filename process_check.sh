#! /bin/bash

PROCESS_COUNT=`pgrep ^nginx | wc -l`

echo "nginx process $PROCESS_COUNT"

if [ $PROCESS_COUNT=0 ] ;  then
	echo "nginx is not running."
	systemctl start nginx && echo "nginx is running."
else
	echo "nginx is running."
fi

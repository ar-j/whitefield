#!/bin/bash

DIR=`dirname $0`
watch -n2 -d $DIR/whitefield_status.sh &
WATCH_PID=$!
read -n 1 ans
kill $WATCH_PID
if [ "$ans" == "?" ]; then
	$DIR/show_menu.sh
else
	sleep 1
	echo
fi

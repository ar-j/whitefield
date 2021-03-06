#!/bin/bash

DIR=`dirname $0`
. $DIR/helpers.sh

function msgq_status()
{
	ipcs -q
}

function elap_time()
{
	wfpid=`wf_get_pid`
	if [ "$wfpid" == "" ]; then
		echo "Whitefield stopped"
		exit
	fi
	et=`ps -p $wfpid -o etime=`
	wf_elap_time=`echo $et`
}

function get_route_list()
{
	echo "TODO: Show route count on BR ... how to identify which node is BR??"
}

function main()
{
	elap_time
	echo "Simulation elapsed time: $wf_elap_time"

	msgq_status

	get_node_list
	echo "Node count: ${#nodelist[@]}"
	echo ;

	al_cmd "cmd_mac_stats"
	echo ;
	echo ;

	get_route_list

	echo ;
	str=`uptime`
	pcpu=`ps -h -p $wfpid -o "%C"`
	memusage=`pmap $wfpid | tail -1 | awk '{print $2}'`
	echo "System load avg:${str/*:/}"
	echo "Airline CPU:$pcpu%, Memory:$memusage"
	echo ;

	echo "Press ctrl-c to exit, ? for menu..."
}

#Processing begins here...
main $*

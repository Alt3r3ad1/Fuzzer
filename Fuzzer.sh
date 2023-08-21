#!/bin/bash

if [ $1 = "" ]; then
	echo "Fuzzer by:Alt3r3ad1"
	echo "Method for use: ./Fuzzer.sh 'server:port'"
else
	server=$(echo "$1" | cut -d ':' -f 1)
	port=$(echo "1" | cut -d ':' -f 2)
	length=100

	while true; do
	    payload=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "$length" | head -n 1)

	    echo -n "$payload" | wc -c
	    echo "$payload" | nc -w 25 "$server" "$port"
	    status=$?
	    if [ "$status" -eq 1 ]; then
	    	echo "DDOS Successful or Blocked by Firewall"
		exit 1
	    fi
	    length=$((length + 100))
	    sleep 1
	done
fi

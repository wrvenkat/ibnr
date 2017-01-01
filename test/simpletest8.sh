#!/bin/bash

line_1=$(cat /etc/bumblebee/xorg.conf.nvidia | grep "BusID \"PCI:01")
line_1=${line_1%" "}
line_1=${line_1#" "}

index1=0
for comment in $line_1;do
    if [ $index1 -eq 0 ]; then
	if [ "$comment" == "#" ]; then
	    printf "BusID commented\n"
	else
	    printf "BusID not commented\n"
	    exit 0
	fi
    fi
done

#!/bin/bash

# See if bumblebee should be installed
bus_line=$(lspci | egrep 'VGA|3D' | grep NVIDIA)
if [ -z "$bus_line" ]; then
    printf "No nVidia card detected. Exiting\n"
    exit 0;
fi

# See if BusID needed to be added to /etc/bumblebee/xorg.conf.nvidia
line_1=$(cat /etc/bumblebee/xorg.conf.nvidia | grep "BusID \"PCI:01")
line_1=${line_1%" "}
line_1=${line_1#" "}

index1=0
for comment in $line_1;do
    if [ $index1 -eq 0 ]; then
	if [ "$comment" == "#" ]; then
	    printf "BusID commented\n"
	    break;
	else
	    #printf "BusID not commented\n"
	    exit 0
	fi
    fi
done

#get Bus ID
index1=0
for arr in $bus_line; do
    if [ $index1 -eq 0 ]; then
	orig_IFS="$IFS"
	IFS=.
	index2=0
	for bus_id in $arr; do
	    if [ $index2 -eq 0 ]; then
		break;
	    fi
	done
	IFS="$orig_IFS"
	break;
    fi
done

#printf "BusID of nVidia is %s\n" "$bus_id"

#get BusID line no
line=$(cat /etc/bumblebee/xorg.conf.nvidia | grep "BusID \"PCI:01" -n)
index1=0
for grep_str in $line; do
    if [ $index1 -eq 0 ]; then
	orig_IFS="$IFS"
	IFS=:
	index2=0
	for line_no in $grep_str; do
	    if [ $index2 -eq 0 ]; then
		break;
	    fi
	done
	IFS="$orig_IFS"
	break;
    fi
done

printf "Line no is %s\n" "$line_no"

#Add uncommented BusID

if ! sudo su -c "cp /etc/bumblebee/xorg.conf.nvidia /etc/bumblebee/xorg.conf.nvidia.backup"; then
    printf "Failed to create backup of /etc/bumblebee/xorg.conf.nvidia."
    printf "Please consult %s\n" "$HELP"
fi

printf "Created backup of /etc/bumblebee/xorg.conf.nvidia\n"

index1=1
line=
msg=
while read line; do
	msg+=$(printf "%s" "$line\n")
	if [ $index1 -eq $line_no ]; then
		msg+=$(printf "BusID \"PCI:%s:0\"%s" "$bus_id" "\n")
	fi
	((index1+=1))
done < /etc/bumblebee/xorg.conf.nvidia.backup

printf "$msg" > test.txt

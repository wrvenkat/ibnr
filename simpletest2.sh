#!/bin/bash

# This script reads from the ppa-list file and installs them based on the options passed as required by the user.

#TODO: Set only the file name and 
PPALIST_FILE="/media/Academics/Current/My Scripts/SystemConfigure/ppa-list"
DBG_FLG=1
LOG_ERROR_FLG=1
ERROR_LOG_FILE="/media/Academics/Current/My Scripts/SystemConfigure/error.log"
# The line content after co
xstr=
declare -a ppa_soft_array

#TODOS:
#1 - write function to parse each line and add PPA
#2 - write a function to install the software for each PPA; also to add functionality to take care of dependency PPA
#3 - write a function to call scripts for softwares that require installation without a PPA
#4 - write individual installation scripts

#error logger function
#accepts 3 arguments. 1-level, 2-step/line, 3-error/message
#1-level can be 0-INFO, 1-ERROR
log_error () {
    if [ -n "$1" ] || [ -n "$2" ] || [ -n "$3" ]
    then
	if [ "$1" -eq 0 ]
	then
	    printf "INFO: %s\t%s\n" "$2" "$3"
	elif [ "$1" -eq 1 ]
        then
   	    printf "ERROR: %s\t%s\n" "$2" "$3" | tee -a "$ERROR_LOG_FILE"
	fi
    fi
}

#removes any comments in the given line and returns whatever is left
removecomments () {
    local substrindex=$(expr index "$1" "#")
    if [ $substrindex -eq 0 ]
    then
	xstr="$1"
	return 1
    else
	((substrindex-=1))
	xstr=${1:0:substrindex}
	return 0
    fi
}

#main function
main () {
    local index=1
    local cleanstr=""
    while read line
    do
	# remove comments from the line
	removecomments "$line"
	if [ "$xstr" != "" ]
	then
	    if [ $DBG_FLG -eq 1 ]
	    then
		msg=$(printf "Line %d: %s\n" "$index" "$xstr")
		log_error 0 "main" "$msg"
	    fi

	    #store this line in the array ppa_soft_array with actual line number in file
	    temp=$( printf "%s-%s" "$line" "$index")
	    create_soft_array "$temp"
	    #call the add and install function
	fi
	xstr=
	((index+=1))
    done < "$PPALIST_FILE"
}

main

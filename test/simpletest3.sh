#!/bin/bash
#reads from the ppa_list file and outputs

PPALIST_FILE="/media/Academics/Current/My Scripts/SystemConfigure/ppa-list"
# The line content after comments are removed
xstr=

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

while read line
do
    column_count=1
    name=
    prog_name=
    ppa=
    type_of_install=
    properties=
    comments=
    removecomments "$line"
    if [ "$xstr" != "" ]
    then
	name=
	prog_name=
	ppa=
	type_of_install=
	properties=
	comments=
	#printf "Processing line %s\n" "$xstr"
	for column in $line
	do
	    if [ -n "$column" ]
	    then
		if [ $column_count -eq 1 ]
		then
		    name=$column
		elif [ $column_count -eq 2 ]
		then
		    prog_name=$column
		elif [ $column_count -eq 3 ]
		then		 
		    ppa=$column
		elif [ $column_count -eq 4 ]
		then		 
		    type_of_install=$column
		elif [ $column_count -eq 5 ]
		then		 
		    properties=$column
		elif [ $column_count -eq 6 ]
		then		 
		    comments=$column
		fi
		((column_count+=1))
            else
		printf "No value found for column %s\n" "$column_count"
		#exit 1
	    fi
	done
	if [ $column_count -ge 6 ]
	then
	    printf "Name: %s ProgName: %s PPA: %s TOInstall: %s Props: %s Comments: %s\n" "$name" "$prog_name" "$ppa" "$type_of_install" "$properties" "$comments"
	fi
    fi
done < "$PPALIST_FILE"

#!/bin/bash

get_props_values() {
    local props_count=1
    local orig_IFS="$IFS"
    #initialize
    props1_value_script=
    props2_value_dependency=
    props3_value_todo=
    props4_value_upgrade=

    if [ -n "$1" ]
    then
	printf "Received props data is %s\n" "$1"
	IFS=:
	for props in "$1"
	do
	    if [ $props_count -eq 1 ]
	    then
		props1_value_script=$props
	    elif [ $props_count -eq 2 ]
	    then
		props2_value_dependency=$props
	    elif [ $props_count -eq 3 ]
	    then
		props3_value_todo=$props
	    elif [ $props_count -eq 4 ]
	    then
		props4_value_upgrade=$props
	    fi
	    ((props_count+=1))
	done
	printf "Props_count is %s\n" "$props_count"
	if [ $props_count -ne 5 ]
	then
	    printf "get_props_value(): Error when parsing properties.\n"
	fi
    else
	printf "get_props_value(): One of the two required arguments are empty\n"
    fi
    IFS="$orig_IFS"					    
}

print_props_values() {
    printf "Props1_Script: %s\tProps2_dependency: %s\tProps3_todo: %s\tProps4_upgrade: %s\n" "$props1_value_script" "$props2_value_dependency" "$props3_value_todo" "$props4_value_upgrade"
}

get_props_values "0:0:0:0"
print_props_values

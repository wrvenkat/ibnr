#!/bin/bash

str1=

func_read(){

    arg1="$1"
    arg2="$2"

    printf "arg1 is %s and arg2 is %s\n" "$arg1" "$arg2"
    str1=
    
    IFS=
    while read -r -N 1 char; do
	#printf "%s\n" "$line"
	str1="$str1""$char"
    done


}

printf "Script to test\n"

cat config1.txt | func_read val1 val2

printf "Str1 value is\n%s\nDONE\n" "$str1"

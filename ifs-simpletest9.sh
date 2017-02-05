#!/bin/bash

val="\"\test1\test foldertest\fi'''le name3\""
oldIFS="$IFS"
IFS=\"
index=1
#if IFS has a different value than the default, then that value along with any whitespace
#is used to do wordsplitting
for item in $val; do
    printf "Item %s:%s\n" "$index" "$item"
    ((index+=1))
done

IFS="$oldIFS"

while IFS=; read line; do
    printf -v var1 "%q" "$line"
    printf "Var1:%s\n" "$var1"
done < config1.txt

IFS="$oldIFS"

#!/bin/bash

#!/bin/bash

#This script is to test if we can write a script that is secure and perform a safe tilde expansion.
#Tilde Expansion - Explained here - https://www.gnu.org/software/bash/manual/bash.html#Tilde-Expansion
#Tilde Expansion - For any word beginning with an unquoted ~, all characters (including whitespace[?]) up to the first unquoted slash
#are considered tilde-prefix.
# If there are no unquoted characters in this tilde-prefix, then all characters following the ~ are considered as a possible login name.
# This tilde-prefix is then expanded as required.

#performs a safe expansion of the provided value
#Returns true if expansion was successful in which case, the expanded value can
#be obtained from the xpandedPath variable
#Returns false if expansion failed
#Takes a string as an argument
xpandedPath=
safe_tilde_expansion(){
    if [ -z "$1" ]; then
	xpandedPath=
	return 1;
    fi

    local given_path="$1"
    local char=
    local escaped_char=
    local saw_quotes=
    local tilde_present=0
    local saw_FWD_Slash=
    local saw_slash=0

    printf "Given path is %s\n" "$1"
    #this is done to prevent read ignoring leading and trailing IFS characters
    local orig_IFS="$IFS"
    IFS=
    #find if there is an unquoted ~
    while read -r -N 1 char; do
	#printf "char is %s\n" "$char"
	#any char prefixed by \ is taken literally
	if [ "$saw_slash" -eq 1 ]; then	    
	    #if we see an escaped / or space then we break
	    if [ "$char" == '/' ] || [ "$char" == $' ' ] || [ "$char" == $'\t' ]; then
		break;
	    elif [ "$char" == '~' ]; then
		tilde_present=1
	    fi
	    escaped_char="$escaped_char""$char"
	else
	    if [ "$char" == '\' ]; then
		saw_slash=1
	    elif [ "$char" == '~' ]; then
		tilde_present=1
		escaped_char="$escaped_char""$char"
	    elif [ "$char" == $' ' ] || [ "$char" == $'\t' ]; then
		break;
	    else		
		 escaped_char="$escaped_char""$char"
	    fi
	fi
    done < <(printf "%s" "$given_path")
    #restore the IFS
    IFS="$orig_IFS"

    printf "Path for expansion is %s and tilde_present is %s\n" "$escaped_char" "$tilde_present"
    local expanded_path=

    if [ "$tilde_present" -eq 1 ]; then
	#here, after replacing the value of escaped_char,
	#eval will perform the expansion and expand the resultant
	#value and assign that value back to expanded_path

	#IMPORTANT!
	#Unfortunately, what's mentioned in the next pragraph won't happen because Bash preserves the meaning after expansion.
	#What that means is that, for an assignment like var="~veasda" is the original value of a variable, irrespective
	#of "$var" or $var, (the quotes are removed from the firs quoting) the value - ~veasda is retained as a whole
	#and no expansion of any sort is done even when the value is passed to a function or in a variable assignment.
	#This means, we have to force an eval (which means force a second interpretation) to perform an expansion to get the meaning of the tilde present on the value.
	
	#the same can be triggered for an unquopted ~ ?by calling a function with the path to
	#be expanded as the argument. But, we need to be cautious about whitespace being present.
	
	if eval expanded_path="$escaped_char"; then
	    printf "Expanded path is %s\n" "$expanded_path"
	fi
    fi
    printf "\n"

    return 0
}

var1="~venkat"
var2=~venkat
var3=\~venkat
var4="~"venkat
var5='~'venkat
var6="\"~\"venkat\ dir\/"
var7="~"

safe_tilde_expansion "$var1"
safe_tilde_expansion "$var2"
safe_tilde_expansion "$var3"
safe_tilde_expansion "$var4"
safe_tilde_expansion "$var5"
safe_tilde_expansion "$var6"
safe_tilde_expansion "$var7"

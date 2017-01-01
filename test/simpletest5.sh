#!/bin/bash
DISP_FLG=0
INSTALL_FLG=0
TYPE_ARG=
FILE_ARG=

#Due to the requirement of parsing arguments passed and with the restriction that getopt has some
#different way of parsing and outputting the optional parameter passed to short options, we are
#limiting the way arguemnts can be passed in unambiguously - See man getopt
display_help_message(){
    printf "Description:\n------------\n\tThis script installs most commonly required software on an Ubuntu system. The script installs softwares from PPA channels and also runs some additional scripts to install softwares to be compiled form source. The script parses a PPA list file with configuration information to do this. Output includes a similar file which can be used in further processing like trying to re-install failed installations and/or restore configuration information from a backup based on the installed softwares.\n\nUsage:\n------\n\t./install-ppa.sh arguments\n\nArguments\n---------\n\t-h\t\t\t\t- Display this message and quit.\n\t--file=ppa-list-file-path\t- The file to be used for displaying or installing instead of the default one.\n\t--display\t\t\t- Display the contents of the PPA list file provided as argument to the file option. If this is not provided, display the default file.\n\t--install\t\t\t- Install the contents of the PPA list file provided as argument to the file option. If not provided, install the default file.\n\t--type=[*,b,d,d1,d2...]\t\t- Used in conjuction with --display and --install options, a value to this option indicates the type of software to be displayed or installed. By default, the desktop level indicated by the value d is used. * - all, b - basic, d - desktop, d1 - development, dx - other types of installation if present in the target PPA list file.\n"
}

# read the options, parse them and set some global variables
parse_args(){

    local args="$@"
    
    if [ -z "$args" ]; then
	display_help_message
	exit 0
    fi

    local parsed_args=$(getopt -o h -l display,install,help,type::,file: -n 'install-ppa' -- "$@" 2>&1)

    #an ugly way of finding if the parsing of the arguments went through successfully
    local line_count=$(echo "$parsed_args" | wc -l)
    local index=1
    #if we have more than 1 line then one must be the failure
    if [ $line_count -gt 1 ] || [ -z "$parsed_args" ]; then
	if [ $line_count -gt 1 ]; then
	    while read line; do
		if [ $index -eq 1 ]; then
		    printf "%s\n" "$line"
		    ((index+=1))
		    break
		fi
	    done < <(echo "$parsed_args")
	else
	    printf "Invalid arguments received. Use -h or --help to see usage.\n"
	fi
	exit 0
    fi
    
    #remove leading space(s).
    local new_args=
    index=1
    for i in $parsed_args; do
	if [ $index -eq 1 ]; then
	    new_args=$i
	    ((index+=1))
	else
	    new_args+=" $i"
	fi
    done

    parsed_args="$new_args"
    set -- $parsed_args

    while true; do
	case "$1" in
	    -h | --help) display_help_message; break; exit 0; ;;
	    --display) DISP_FLG=1; shift ;;
	    --install) INSTALL_FLG=1; shift ;;
	    --type) TYPE_ARG=$2; shift 2 ;;
	    --file) FILE_ARG=$2; shift 2;;
	    --) break ;;
	    *) printf "Invalid arguments received. Use -h or --help to see usage.\n"; exit 0;;
	esac
    done

    #do some further processing on the option arguments to remove enclosing quotes
    if [ -n "$TYPE_ARG" ]; then
	local temp="${TYPE_ARG#\'}"
	temp="${temp%\'}"
	TYPE_ARG="$temp"
    fi

    if [ -n "$FILE_ARG" ]; then
	temp="${FILE_ARG#\'}"
	temp="${temp%\'}"
        FILE_ARG="$temp"
    fi

    #set default values and see if provided file exists
    if [ -z "$TYPE_ARG" ]; then
	TYPE_ARG='d'
    fi

    if [ -n "$FILE_ARG" ] && [ -a "$FILE_ARG" ]; then
	printf "File exists\n"
    else
	printf "File doesn't exist\n"
    fi

    printf "After parsing values are,\nDISP_FLG:%s\nINSTALL_FLG=%s\nTYPE_ARG:%s\nFILE_ARG:%s\n" "$DISP_FLG" "$INSTALL_FLG" "$TYPE_ARG" "$FILE_ARG"
}

parse_args "$@"

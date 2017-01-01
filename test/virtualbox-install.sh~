#!/bin/bash

# Install VBox on your Ubuntu release
VBOX_DEB_REPO="deb http://download.virtualbox.org/virtualbox/debian"
VBOX_SRC_REPO="# deb-src http://download.virtualbox.org/virtualbox/debian"

index=0
for release in $(lsb_release -c); do
    if [ $index -eq 1 ]; then
	release=$release
    fi
    ((index+=1))
done

if [ -z "$release" ]; then
    printf "Unable to determine release\n"
    exit 1
fi

printf "Installing dkms...\n"
sudo apt-get install dkms

sudo printf "%s %s contrib\n%s %s contrib\n" "$VBOX_DEB_REPO" "$release" "$VBOX_SRC_REPO" "$release" >> /etc/apt/sources.list

if wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add - && wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - ; then
    printf "Refreshing repository....\n"
    if sudo apt-get update && sudo apt-get install virtualbox-5.1; then
	printf "VirtualBox 5.1 installed\n"
    else
	printf "Error refreshing and installing. Please run, \"sudo apt-get update && sudo apt-get install virtualbox-5.1\" manually\n"
    fi
else
    printf "Error adding VBox keys. Please go to https://www.virtualbox.org/wiki/Linux_Downloads\n"
fi

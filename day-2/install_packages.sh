#!/bin/bash
#

# This script checks if the user is root 
if [ $EUID -ne 0 ]
then
	echo "run as root user"
	exit 1
fi

packages=("nginx" "curl" "wget")

for package in ${packages[@]}
do
	echo "checking package ...."

	dpkg -s $package >/dev/null 2>&1
#   $? is a special variable in bash that holds the exit status of the last executed command. 
	if [ $? -eq 0 ]
	then
		echo "alrerady installed ...."
	else
		echo "not installed"
		echo "installing"
		sudo apt-get install -y $package
	fi
done

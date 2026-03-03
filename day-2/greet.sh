#!/bin/bash
#
# -z: checks if the length of the string is zero. If it is zero, it returns true; otherwise, it returns false.
if [ -z $1 ];
then
	echo "Usage: ./greet.sh <name>"
else
	echo "Hello, $1 "
fi	
		

#!/bin/bash
#
#
#
function demo_local(){
	#local variable
	local loc_var=56
	echo "value loc_var=$loc_var"
}

demo_local

#local variable is not accessible outside the function
echo "value loc_var=$loc_var"

# global variable
loc_var=100
echo "value loc_var=$loc_var"


#!/bin/bash

# Task 4


read -p "Enter the number: " Num

# -gt is used to check the number is greater than 0 or not
if [ $Num -gt 0 ];then
	echo "Number is positive"
    
# -lt is used to check the number is less than 0 or not
elif [ $Num -lt 0 ];then
	echo "Number is negative"

else
    echo "Number is zero"
fi
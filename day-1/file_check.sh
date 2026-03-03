#!/bin/bash

# Task 4

# read -p is used to take input from user and store it in variable
read -p "enter the filename: " filename

# -f is used to check the file exists or not
if [ -f $filename ];then
	echo "file exists"
else
	echo "file not exists"
fi

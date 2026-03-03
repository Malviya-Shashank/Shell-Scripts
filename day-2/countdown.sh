#!/bin/bash
# task 2 ===> Takes a number from the user,Counts down to 0 using a while loop,Prints "Done!" at the end

read -p "enter the number: " number

while [ $number -gt 0 ];
do
	echo "$number"
       	((number --))

done	
echo "Done!"

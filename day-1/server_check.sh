#!/bin/bash

service="nginx"

read -p "Do you want to check the status? (y/n) " choice

if [ "$choice" == "y" ];then
	status=$(systemctl is-active $service)

	if [ "$status" == "active" ];then
		echo " $service is Active and Running....."
    else
		echo " $service is not active"
	fi
else
	echo "skipeed ...."
fi	


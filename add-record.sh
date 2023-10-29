#!/bin/bash
file = "./database"

echo Please enter hostname?
read hostname
echo

        grep -q $hostname $file
        if [ $? -eq 0 ]
        then
        echo ERROR -- Hostname $hostname already exist
        echo
        exit 0
        fi

echo Please enter IP address?
read IP
echo

        grep -q $IP $file
        if [ $? -eq 0 ]
        then
        echo ERROR -- IP $IP already exist
        echo
        exit 0
        fi


echo Please enter Description?
read description
echo

echo $hostname $IP $description >> $file


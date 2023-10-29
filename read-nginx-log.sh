#!/bin/bash
tail -fn0 /var/log/nginx/error.log | while read line
do
	echo $line | egrep -i "not found""
        if [ $? = 0 ]
        then
        echo $line >> /tmp/filtered-messages
        fi
done



#!/bin/bash

system_mails="hamid@hamid.local"

if [ -s /tmp/filtered-messages ]
        then
        cat /tmp/filtered-messages | sort | uniq | mail -s "CHECK: Syslog Errors" $system_mails
        rm /tmp/filtered-messages
        else
fi

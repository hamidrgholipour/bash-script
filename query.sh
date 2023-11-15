#!/bin/bash

IP=192.168.1.10
PORT=3306
USER=root
PASS=123
query='select * from users;'

mysql -h $IP -P $PORT -u$USER -p$PASS persons -e $query

#! /bin/bash

user="root"
pass="123"
sudo apt install sshpass -y 

for server in `cat ipAddress`;
do
    sshpass -p $pass ssh-copy-id -i ~/.ssh/id_rsa.pub $user@$server
done


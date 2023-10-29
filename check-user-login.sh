#!/bin/bash

echo "please enter date (like Sat Oct 28)"
read d m da 
last | grep "$d $m $da"

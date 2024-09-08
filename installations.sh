#!/bin/bash

userid=$(id -u)
echo "userid is: $userid"

if [ $userid -eq 0 ]
then 
echo "exit status is success"
else
echo "please run this script with the root privileges"
fi 

dnf install git -y 

ls -ltr 

lshsla -ls

ls -l 

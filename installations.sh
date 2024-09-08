#!/bin/bash

userid=$(id -u)
echo "userid is: $userid"

if [ $userid -ne 0 ]
then 
echo "please run this script with the root privileges"
exit 1
fi 

dnf list installed git 

# ls -ltr 

# lshsla -ls

# ls -l 

if [ $? -ne 0 ]
then 
echo "git is not installed. please install it now"
dnf install git -y 
else
echo "git is already installed. nothing to do"
fi 
#!/bin/bash

userid=$(id -u)
# echo "userid is: $userid"

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
    if [ $? -ne 0 ]
    then 
        echo "git installation is not success.. check it now"
        exit 127
    else
        echo "git installation is successfull"
    fi 
else
    echo "git is already installed. nothing to do"
fi 

dnf list installed mysql 

if [ $? -eq 0 ]
then 
echo " mysql is already installed,nothing can be done"
else
echo "mysql is not installed. please install it now"
dnf install mysql -y 
fi 

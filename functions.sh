#!/bin/bash 

userid=$(id -u)

validate(){
    if [ $1 -eq 0 ]
    then 
        echo "$2 is success"
    else
        echo "$2 is failed, please check"
    fi 
}

if [ $userid -ne 0 ]
then 
    echo " please run the script with root priviledges"
    exit 127 
else 
    echo "It is already running with the root priviledges"
fi 

dnf list installed mysql

validate $? "listing the mysql"
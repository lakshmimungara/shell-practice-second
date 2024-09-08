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

if [ $? -ne 0 ]
then 
echo "mysql is not installed. please install it now"
dnf install mysql -y 
validate $? "Installing mysql"
if [ $? -ne 0 ]
then 
echo "mysql installation is failed, check the script and run the command again"
exit 23
else
echo "Mysql installation is succeded"
fi 
else
echo "mysql already installed."

dnf list installed git 

if [ $? -eq 0 ]
then 
echo "git is already installed"
if [ $? -eq 0 ]
echo "git installation is already succeded"
else
echo "git installaton is failed"
exit 12 
fi 
else 
echo "git is not installed. please install it now"
dnf install git -y 
validate $? "Installing git"
#!/bin/bash 

userid=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[30m"



check_root(){
    if [ $userid -ne 0 ]
then 
    echo -e " $R please run the script with root priviledges $N"
    exit 127 
else 
    echo -e " $G It is already running with the root priviledges $N"
fi 
}

validate(){
    if [ $1 -eq 0 ]
    then 
        echo -e " $G $2 is success $N"
    else
        echo -e " $R $2 is failed, please check $N"
    fi 
}

check_root

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo -e "$Y mysql is not installed. please install it now $N"
    dnf install mysql -y 
    validate $? "Installing mysql"
    if [ $? -ne 0 ]
    then 
        echo -e " $R mysql installation is failed, check the script and run the command again $N"
        exit 23
    else
        echo -e "$G Mysql installation is succeded $N"
    fi 
else
    echo -e "$G mysql already installed.$N"
fi 

dnf list installed git 

if [ $? -ne 0 ]
then 
    echo -e "$Y git is not installed. please install it now $N"
    dnf install git -y 
    validate $? "Installing git"
    
    if [ $? -eq 0 ]
    then
        echo -e " $G git installation is already succeded $N"  
    else
        echo -e " $R git installaton is failed $N"
        exit 12 
    fi 
else 
    echo -e " $G git is already installed $N"
fi 
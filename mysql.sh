#!/bin/bash

folder="/var/log/expense"
mkdir -p $folder 
script_name=$(echo $0 | cut -d "." -f1)
time=$(date +%Y-%m-%d-%H-%M-%S)
log_file="$folder/$script_name-$time.log"


userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

checking_root(){
    if [ $userid -eq 0 ]
    then 
        echo -e "$G It is already following with the root priviledges $N" | tee -a $log_file
    else
        echo -e "$R Please make sure it should be with the root priviledges $N" | tee -a $log_file
        exit 23
    fi 
}

validating(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 is $R failed $N" | tee -a $log_file
        exit 12 
    else 
        echo -e "$2 is $G succeded $N" | tee -a $log_file
    fi 
}

echo "script started executing at: $(date)" | tee -a $log_file

checking_root

dnf install mysql-server -y &>>$log_file
validating $? "mysql-server installation"

systemctl enable mysqld &>>$log_file
validating $? "enabling mysql"

systemctl start mysqld &>>$log_file
validating $? "starting mysql-server"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
validating $? "setting up the root password"



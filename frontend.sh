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

echo "script started executing at $(date)" &>>$log_file

dnf install nginx &>>$log_file
validating $? "nginx installation"

systemctl start nginx &>>$log_file
validating $? "nginx service start"

systemctl enable nginx &>>$log_file
validating $? "nginx service enable"

rm -rf /usr/share/nginx/html/* &>>$log_file
validating $? "html folder clean"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$log_file
validating $? "frontend zip download"

cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$log_file
validating $? "unzipping frontend"

cp /home/ec2-user/shell-practice-second/expense.conf /etc/nginx/default.d/expense.conf
validating $? "nginx config copy"

systectl restart nginx &>>$log_file
validating $? "nginx restart"
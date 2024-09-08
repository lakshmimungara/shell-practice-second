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

dnf module disable nodejs -y &>>$log_file
validating $? "dnf module disable nodejs"

dnf module enable nodejs:20 -y &>>$log_file
validating $? "dnf module enable nodejs:20"

dnf install nodejs -y &>>$log_file
validating $? "dnf install nodejs"

id expense &>>$log_file
if [ $? -ne 0 ]
then 
  echo -e "user expense does not exist $G creating $N"
  useradd expense &>>$log_file
  validating $? "creating expense user"
else 
  echo -e "user expense already exists $Y skipping $N"
fi 

mkdir -p /app 
validating $? "creating a directory /app"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$log_file
validating $? "downloading backend zip"

cd /app 
rm -rf /app/*
unzip /tmp/backend.zip &>>$log_file
validating $? "unzipping backend"

npm install &>>$log_file
cp /home/ec2-user/shell-practice-second/backend.service /etc/systemd/system/backend.service 

dnf install mysql -y &>>$log_file
validating $? "installing mysql"

mysql -h mysql.daws81s.fun -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
validating $? "running schema"

systemctl daemon-reload &>>$log_file
validating $? "reload deamon"

systemctl enable backend &>>$log_file
validating $? "enabling backend"

systemctl restart backend  &>>$log_file
validating $? "restarting backend"
#!/bin/bash 

#loops

# for i in {0..15}
# do 
# echo $i 
# done 


# packages installation 

folder="/var/log/shell-script"
mkdir -p $folder 
script_name=$(echo $0 | cut -d "." -f1)
time=$(date +%Y-%m-%d-%H-%M-%S)
log_file="$folder/$script_name-$time.log"


userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[35m"

checking_root(){
    if [ $userid -eq 0 ]
    then 
        echo -e "$G It is already following with the root priviledges $N" | tee -a &>>$log_file
    else
        echo -e "$R Please make sure it should be with the root priviledges $N" | tee -a &>>$log_file
        exit 23
    fi 
}

validating(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 is $R failed $N" | tee -a &>>$log_file
        exit 12 
    else 
        echo -e "$2 is $G succeded $N" | tee -a &>>$log_file
    fi 
}

usage(){
    echo -e "$R usage:: $Y sudo sh day-12-practice.sh package1 package2....."
}

echo "script started executing at: $(date)" | tee -a $log_file

checking_root

if [ $# -eq 0 ]
then 
    usage 
fi 

for package in $@
do 
    dnf list installed $package &>>$log_file
    if [ $? -ne 0 ]
    then 
        echo -e "$Y $package is not installed.please install it now" | tee -a $log_file
        dnf install $package -y  &>>$log_file
        validating $? "Installing $package:" 
    else 
       echo -e "$G $package is already $Y installed $N" | tee -a $log_file
    fi 
done 

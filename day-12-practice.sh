#!/bin/bash 

#loops

# for i in {0..15}
# do 
# echo $i 
# done 


# packages installation 

folder="/var/log/shell-script"
mkdir -p $folder 
script_name=$(echo "day-12-practice" | cut -d "." -f1)
time=$(date +%Y-%m-%d-%H)
log_file="$folder/$script_name-$time.log"


userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[30m"

checking_root(){
    if [ $userid -eq 0 ]
    then 
        echo -e "$G It is already following with the root priviledges $N"
    else
        echo -e "$R Please make sure it should be with the root priviledges $N"
    fi 
}

validating(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$R $2 is failed $N"
        exit 12 
    else 
        echo -e "$G $2 is succeded $N"
    fi 
}

usage(){
    echo -e "$R usage:: $N sudo sh day-12-practice.sh package1 package2....."
}


checking_root

if [ $# -eq 0 ]
then 
    usage 
fi 

for package in $@
do 
    dnf list installed $package
    if [ $? -ne 0 ]
    then 
        echo -e "$R $package is not installed.please install it now $N"
        dnf install $package -y 
        validating $? "Installing $package:"
    else 
       echo -e "$G $package is already installed $N"
    fi 
done 

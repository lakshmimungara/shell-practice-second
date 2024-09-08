#!/bin/bash 

#loops

# for i in {0..15}
# do 
# echo $i 
# done 


# packages installation 

userid=$(id -u)

checking_root(){
    if [ $userid -eq 0 ]
    then 
    echo "It is already following with the root priviledges"
    else
    echo "Please make sure it should be with the root priviledges"
    fi 
}

validating(){
    if [ $1 -ne 0 ]
    then 
    echo "$2 is failed"
    exit 12 
    else 
    echo "$2 is succeded"
    fi 
}

checking_root

for package in $@
do 
    dnf list installed $package
    if [ $? -ne 0 ]
    then 
        echo "$package is not installed.please install it now"
        dnf install $package -y 
        validating $? "Installing $package is:"
    else 
       echo "Installing $package"
    fi 
done 

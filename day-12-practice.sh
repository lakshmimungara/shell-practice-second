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

# validating(){
#     if [ $1 -ne 0 ]
#     then 
#     echo "$2 is failed"
#     exit 12 
#     else 
#     echo "$2 is succeded"
#     fi 
# }

checking_root

for package in $@
do 
echo $package 
done 

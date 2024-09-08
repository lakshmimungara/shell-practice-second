#!/bin/bash 

Date=$(date)
echo "Today's date is: $Date"

# data types 

number1=$1 
number2=$2 

sum=$(($number1+$number2))
echo "sum of two numbers are: $sum"


#special variables 

echo "present working directory: $PWD"
echo "all the variables passed to the script: $@"
echo "number of variables passed: $#"
echo "script name: $0"
echo "home directory: $HOME"
echo "process id of present script: $$"
sleep 100 &
echo "process id of last background command: $!"

#conditions

number=$1

if [ $number -eq 0 ]
then 
echo "exit status is success"
else 
echo "otherwise from 1 to 127 are failure"
fi 





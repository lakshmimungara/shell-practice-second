#!/bin/bash


# printing hello world 
echo "Hello world"


# conversation between two persons 

person1=$1
person2=$2

echo "$person1:: hai $person2, how are you?"
echo "$person2:: hello $person1, I am good and what about you?"
echo "$person1:: I am also good, How is everything going on?"
echo "$person2:: nothing much, I am just learning and practicing shell scripting"



# read variable

echo "please enter the username:"

read username

echo "username entered is: $username"
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


# hiding the username and password 

echo "please enter the username:"
read -s username 
echo "username entered is: $username"
echo "please enter the password:"
read -s password 
echo "password entered is: $password"

# Arrays 

BTS=("RM" "JIN" "SUGA" "J-HOPE" "V" "JIMIN" "JUNGKOOK")
echo "leader of the group is: $BTS[0]"
echo "world wide handsome is: $BTS[1]"
echo "world famous rapper is: $BTS[2]"
echo "the best dancer is: $BTS[3]"
echo "most handsome man in the world: $BTS[4]"
echo "The cutest man: $BTS[5]"
echo "The best singer: $BTS[6]"
echo "All the wonderful persons and my fav: {$BTS[@]}"



#!/bin/bash 
FIRST_NAME="$1"
# echo "Hello, $FIRST_NAME!"
# echo "total_num_of_argument": $#
if [ "$#" -eq 0 ]; then
    echo "pls run the script like this- $0 <name>"
    exit 1
else
   echo "Hello, $FIRST_NAME!"
fi 



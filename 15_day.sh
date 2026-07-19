#!/bin/bash

#Day 15. Write a script that reads three numbers 
#(as args) and prints the largest. Concept: 
#nested conditionals / comparison logic. Hint: compare pairwise.


num1=$1
num2=$2
num3=$3

if ! [[ $# -eq 3 ]]; then
    echo "Usage: pls enter the 3 number argument" >&2
    exit 1
fi


if ! [[ $num1 =~ ^-?[0-9]+$ ]] || ! [[ $num2 =~ ^-?[0-9]+$ ]] || ! [[ $num3 =~ ^-?[0-9]+$ ]]; then
    echo "Usage: pls enter the number only as an argument" >&2
    exit 1
fi

for i in "$@"; do
    if [[ i -gt $num1 ]]; then
        num1=$i
    fi
done

echo "larget number is: $num1"









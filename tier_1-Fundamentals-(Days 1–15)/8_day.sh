#!/bin/bash

#Day 8. Write a script that reads a number and prints 
# whether it's positive, negative, or zero. Concept: 
# numeric comparison. Hint: -gt, -lt, -eq.



num=$1


if ! [[ $# -eq 1 ]]; then
    echo "usage: valid 1 number only" >&2
    exit 1
fi

if ! [[ $num =~ ^-?[0-9]+$ ]]; then
    echo "pls enter the valid number"  >&2
    exit 1
fi

if [[ $num -gt 0 ]]; then
    echo "number is positive"
elif [[ $num -lt 0 ]]; then
    echo "number is negative"
else
    echo "number is zero"
fi




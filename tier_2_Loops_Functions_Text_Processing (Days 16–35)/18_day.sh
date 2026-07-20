#!/bin/bash

# Day 18. Write a script that prints the multiplication table 
#(1–10) for a number passed as an argument. Concept: loops + arithmetic.


num=$1

if [[ $# -ne 1 ]]; then
    echo "Usage: pls enter 1 num as an argument" >&2
    exit 1
fi


if ! [[ $num =~ ^-?[0-9]+$ ]]; then
    echo "Usage: pls enter num only as an argument" >&2
    exit 1
fi

for i in {1..10}; do 
    echo "$i*$num= $(($i*$num))"
done



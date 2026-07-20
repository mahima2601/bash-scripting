#!/bin/bash

# Day 24. Write a script that takes a CSV file and prints 
#only the 1st and 3rd columns. 
#Concept: awk / cut with field separators. Hint: awk -F, '{print $1, $3}'.

file=$1

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <csvfile>" >&2
    exit 1
fi
if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a file" >&2
    exit 1
fi

awk -F, '{print $1, $3}' "$file"


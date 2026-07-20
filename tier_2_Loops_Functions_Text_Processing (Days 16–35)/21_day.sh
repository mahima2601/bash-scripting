#!/bin/bash

# Day 21. Read a file line by line and print only lines longer 
# than 80 characters, with their line numbers. Concept: 
#while read loop, ${#line}. Hint: while IFS= read -r line.

file=$1

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <file>" >&2
    exit 1
fi
if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a file" >&2
    exit 1
fi


n=0
while IFS= read -r line; do 
    (( n++ ))
    if (( ${#line} > 80 )); then
        echo "$n: $line"

    fi
done < "$file"
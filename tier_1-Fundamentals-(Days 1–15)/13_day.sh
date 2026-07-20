#!/bin/bash

#Day 13. Write a script that takes a file path and 
#prints its size in human-readable form and its line 
#count. Concept: command substitution, combining tools. Hint: du -h, wc -l.


# ls -lrt  | awk '{print $5}'
file=$1

if [ $# -eq 0 ]; then
    echo "pls run the script like this- $0 <name>" >&2
    exit 1
fi
if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a regular file" >&2
    exit 1
fi

size=$(du -h "$file" | awk '{print $1}')
size=$(wc -l "$file" | awk '{print $1}')


# 3. clear, labeled output
echo "File:  $file"
echo "Size:  $size"
echo "Lines: $lines"





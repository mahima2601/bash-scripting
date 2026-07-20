#!/bin/bash

# Day 31. Write a script that takes a directory and 
#prints the 5 largest files within it (recursively), 
#with sizes. Concept: find + du + sort. Hint: find . -type f -exec du -h {} +.


file=$1

if [[ ! -d "$file" ]]; then
    echo "Error: '$file' is not a directory" >&2
    exit 1
fi

find "$file" -type f -exec du -h {} + | sort -rh | head -5


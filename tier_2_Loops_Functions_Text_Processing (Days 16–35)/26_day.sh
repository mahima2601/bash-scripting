#!/bin/bash

# Day 26. Write a script that strips blank lines and 
#comment lines (starting with #) from a config file and 
#prints the result. Concept: grep -v / sed. Hint: grep -vE '^\s*(#|$)'


# or 
# grep -vE '^\s*(#|$)' "$file"

file=$1

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <file>" >&2
    exit 1
fi
if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a file" >&2
    exit 1
fi

sed '/^#/d; /^$/d' "$file"




#!/bin/bash

# Day 7. Write a script that takes a filename and reports whether 
#it's a regular file, a directory, a symlink, or doesn't exist. 
#Concept: if/elif/else, file tests. Hint: -f, -d, -L, -e.


path=$1
if [[ -L "$path" ]]; then
    echo "it's a symlink"
    
elif [[ -f "$path" ]]; then
    echo "it's regular file"

elif [[ -d "$path" ]]; then
    echo "it's directory"
else
    echo "file doesn't exist"
fi
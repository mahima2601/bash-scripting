#!/bin/bash

#Day 4. Prompt the user to type a directory path, then print whether 
#it exists, and if so whether it's readable and wri#table. 
#Concept: read, file test operators. Hint: -d, -r, -w.

read -p "Enter a directory path: " path 
if [[ -d "$path" ]]; then
    echo "directory exists"
    if [[ -r "$path" ]]; then
        echo "directory is readable"
    fi
    if [[ -w "$path" ]]; then
        echo "directory is writable"
    fi
else 
    echo "directory does not exits"
fi





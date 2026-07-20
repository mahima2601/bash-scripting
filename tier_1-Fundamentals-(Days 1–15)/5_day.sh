#!/bin/bash

# 5. Write a script that checks if a given string argument
# is empty and prints an appropriate message either way. 
# Concept: string tests. Hint: -z, -n, always quote "$1".


str=$1

if [[ -z "$str" ]]; then
    echo "string empty"
else
    echo "string not empty"
fi





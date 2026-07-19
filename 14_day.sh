#!/bin/bash

# Day 14. Write a script that counts how many 
#arguments it received and rejects the run if fewer 
#than 2 are given. Concept: argument validation. Hint: [ "$#" -lt 2 ]



if [[ $# -lt 2 ]]; then
    echo "argument is less than 2" >&2
    exit 1

else
    echo "count of argument: $# "

fi





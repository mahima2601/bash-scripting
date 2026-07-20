#!/bin/bash

#Day 9. Write a script that takes a username argument 
# and checks whether that user exists on the system. 
# Concept: command exit status in conditionals. 
# Hint: id "$1" &>/dev/null.

user=$1

if ! [[ $# -eq 1 ]]; then
    echo "usage: valid 1 username only" >&2
    exit 1
fi

if ! [[ $user =~ ^[a-zA-Z_][a-zA-Z0-9_-]*$ ]]; then
    echo "pls enter the valid username" >&2
    exit 1
fi

if id "$user" &>/dev/null; then
    echo "user exist"
else
    echo "user does not exit"
fi




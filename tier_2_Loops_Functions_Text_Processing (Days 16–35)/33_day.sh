#!/bin/bash

# Day 33. Write a function that converts a number of 
#seconds into Xh Ym Zs format. Concept: arithmetic + 
#functions. Hint: modulo %.


format_duration() {
    local total=$1
    local hours=$((   total / 3600 ))
    local minutes=$(( (total % 3600) / 60 ))
    local seconds=$(( total % 60 ))
    echo "${hours}h ${minutes}m ${seconds}s"
}

format_duration "$1"      # ← call the function, passing the script's $1

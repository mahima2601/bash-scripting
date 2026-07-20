#!/bin/bash

# Day 27. Write a function that takes a full file path 
#and prints the directory, the filename, the basename 
#without extension, and the extension separately. 
#Concept: parameter expansion. Hint: ${path##*/}, ${name%.*}, ${name##*.}.


path_info () {
    local path="$1"
    local dir="${path%/*}"
    local file="${path##*/}"
    local name="${file%.*}"
    local extension="${file##*.}"
    echo "dir=$dir file=$file name=$name extension=$extension"

}
path_info "/var/log/nginx/access.log" 
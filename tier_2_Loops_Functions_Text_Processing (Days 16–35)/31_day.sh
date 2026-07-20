#!/bin/bash

# Day 31. Write a script that takes a directory and 
#prints the 5 largest files within it (recursively), 
#with sizes. Concept: find + du + sort. Hint: find . -type f -exec du -h {} +.

file=$1

large= $(find "$file" -type f -exec du -h {} +) | sort -h 

awk $large '{print $0}'
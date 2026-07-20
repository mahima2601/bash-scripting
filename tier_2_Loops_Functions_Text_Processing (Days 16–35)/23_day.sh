#!/bin/bash

# Day 23. Extract all unique IP addresses from a web server 
#access log and print them sorted by frequency 
#(most frequent first). Concept: awk/grep + sort + uniq -c. Hint: sort | uniq -c | sort -rn


file=$1
echo "$(awk '{print $1}' "$file" | sort | uniq -c | sort -rn)"
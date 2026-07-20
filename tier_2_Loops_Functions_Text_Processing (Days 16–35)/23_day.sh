#!/bin/bash

# Day 23. Extract all unique IP addresses from a web server 
#access log and print them sorted by frequency 
#(most frequent first). Concept: awk/grep + sort + uniq -c. Hint: sort | uniq -c | sort -rn


file=$1

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <logfile>" >&2
    exit 1
fi
if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a file" >&2
    exit 1
fi

echo "total count of warn: $(grep -ic "WARN" "$file")"
echo "total count of info: $(grep -ic "INFO" "$file")"
echo "total count of error: $(grep -ic "ERROR" "$file")"



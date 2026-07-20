#!/bin/bash

# Day 34. Read a list of hostnames from a file and 
#ping each once, printing reachable/unreachable. 
#Concept: loop + per-line action + exit codes. Hint: ping -c1 -W1.



file=$1

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <hostfile>" >&2
    exit 1
fi
if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a file" >&2
    exit 1
fi

while IFS= read -r hostname; do
    [[ -z "$hostname" ]] && continue          # skip blank lines
    if ping -c1 -W1 "$hostname" &>/dev/null; then
        echo "$hostname is reachable"
    else
        echo "$hostname is not reachable"
    fi
done < "$file"
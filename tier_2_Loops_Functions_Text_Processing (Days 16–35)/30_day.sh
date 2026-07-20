#!/bin/bash

# Day 30. Parse a date-stamped log and print only
# entries from the last 24 hours. Concept: awk with 
#date comparison or date arithmetic. Hint: date -d '24 hours ago' +%s

file=$1
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <logfile>" >&2
    exit 1
fi
if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a file" >&2
    exit 1
fi

cutoff=$(date -d '24 hours ago' '+%Y-%m-%d %H:%M:%S')
awk -v c="$cutoff" '$0 >= c' "$file"


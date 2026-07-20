#!/bin/bash

# Day 17. Loop over all .log files in a directory and print 
#each filename with its line count. Concept: globbing in loops. Hint: for f in *.log; do ... done; handle the no-match case.


shopt -s nullglob                 # no-match -> empty (handles the trap)

found=0
for f in *.log; do
    found=1
    echo "$f: $(wc -l < "$f") lines"
done

if (( found == 0 )); then
    echo "No .log files found."
fi



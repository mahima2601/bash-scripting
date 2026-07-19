#!/bin/bash

#Day 10. Write a script that prints all its arguments,
# one per line, with their position number 
#(e.g. 1: foo). Concept: iterating positional params. Hint: $@, $#, a counter.

counter=1
for i in $@; do
    echo "$counter: $i"
    ((counter++))

done




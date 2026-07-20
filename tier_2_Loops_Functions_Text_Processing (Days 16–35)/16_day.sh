#!/bin/bash

# Day 16. Print the numbers 1 to 10, each on its own line, 
#using a for loop. Then do the same with a while loop. 
#Concept: both loop styles. Hint: {1..10}, (( i++ )).

for i in {1..10}; do
    echo "$i"
done

i=1
while (( i <= 10 )); do
    echo "$i"
    (( i++ ))

done

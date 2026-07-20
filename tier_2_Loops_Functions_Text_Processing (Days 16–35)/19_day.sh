#!/bin/bash

# Day 19. Write a function is_even that returns success/failure 
#(via exit code) for a number, and use it in a loop over 1–20.
# Concept: functions, return-as-exit-code. Hint: return 0 / return 1.



is_even() {
    if (( $1%2==0 )); then
        return 0
    else
        return 1
    fi
}

# or- 
# is_even() {
#     (( $1%2==0))
# }


for i in {1..20}; do 
    if is_even "$i"; then
        echo "$i: is even number"
    fi
done



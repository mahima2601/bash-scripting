# Day 3. Write a script that accepts two numbers as arguments and prints their sum, 
#difference, product, and integer quotient. Concept: arithmetic. Hint: $(( ))

#1. easy

#!/bin/bash
num1=$1
num2=$2
# echo "sum=$((num1 + num2))"
# echo "min=$((num1 - num2))"
# echo "into=$((num1 * num2))"
# echo "quo=$((num1 / num2))" 


# 2. all scenarios-

if [[ "$#" != 2 ]]; then
    echo "$0 pls enter valid 2 number after the script" >&2
    exit 1
fi

if ! [[ $num1 =~ ^-?[0-9]+$ ]] || ! [[ $num2 =~ ^-?[0-9]+$ ]]; then
    echo "pls enter only numeric number" >&2
    exit 1
fi


echo "sum=$((num1 + num2))"
echo "min=$((num1 - num2))"
echo "into=$((num1 * num2))"

if [[ $num2 -eq 0 ]]; then

    echo "num2 should not be 0" >&2
else
    echo "quo=$((num1 / num2))" 
fi 


#!/bin/bash

# Day 32. Write a script that validates whether a 
#string passed in is a valid IPv4 address. Concept: 
#regex matching with [[ =~ ]]. Hint: BASH_REMATCH, check each octet ≤ 255.

ip=$1

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <ip-address>" >&2
    exit 1
fi

# 1. Match the STRUCTURE: four groups of 1-3 digits, dot-separated.
#    The ( ) capture each octet into BASH_REMATCH[1..4].
if [[ ! $ip =~ ^([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$ ]]; then
    echo "INVALID: '$ip' (wrong format)"
    exit 1
fi

# 2. Check each captured octet is 0-255.
for octet in "${BASH_REMATCH[@]:1:4}"; do
    if (( 10#$octet > 255 )); then
        echo "INVALID: '$ip' (octet $octet > 255)"
        exit 1
    fi
done

echo "VALID: '$ip'"
exit 0

#!/bin/bash

# Day 22. Given a log file, count how many lines contain 
#"ERROR", "WARN", and "INFO" respectively. Concept: grep -c. Hint: anchor your patterns.


file=$1
echo "total count of warn: $(grep -io "WARN" $file | wc -l)"
echo "total count of info: $(grep -io "INFO" $file | wc -l)"
echo "total count of error: $(grep -io "ERROR" $file | wc -l)"



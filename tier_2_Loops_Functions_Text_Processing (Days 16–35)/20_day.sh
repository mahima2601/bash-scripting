#!/bin/bash

# Day 20. Write a function log() that prints a message prefixed 
#with a timestamp and a log level (INFO/WARN/ERROR passed as the 
#first arg). Concept: function arguments, reusable logging. Hint: you'll reuse this pattern constantly.




log () {
    local level="$1"
    shift 
    local message="$*"
    echo " $(date +"%F %T") $level $message"
}


log INFO "starting up"
log ERROR "something broke"
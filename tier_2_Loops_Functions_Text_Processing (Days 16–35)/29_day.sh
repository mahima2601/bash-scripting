#!/bin/bash

# Day 29. Write a script that retries a command up to
# N times with a 2-second pause between attempts, 
#succeeding as soon as the command does. Concept: retry loop. Hint: for attempt in $(seq 1 "$N").

# 1. Need an attempt count AND a command to run
if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <max-attempts> <command...>" >&2
    exit 1
fi

max_attempts=$1
shift                          # drop N — "$@" is now the command + its args

# 2. Validate the count is a positive integer
if ! [[ "$max_attempts" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: max-attempts must be a positive integer" >&2
    exit 1
fi

# 3. The retry loop
for attempt in $(seq 1 "$max_attempts"); do
    if "$@"; then                                   # run the command; exit 0 = success
        echo "Succeeded on attempt $attempt"
        exit 0                                       # stop as soon as it works
    fi
    echo "Attempt $attempt/$max_attempts failed" >&2
    if (( attempt < max_attempts )); then            # don't sleep after the last try
        sleep 2
    fi
done

echo "All $max_attempts attempts failed" >&2
exit 1


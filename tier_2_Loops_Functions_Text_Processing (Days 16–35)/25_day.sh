#!/bin/bash

# Day 25. Use sed to replace every occurrence of localhost
# with 0.0.0.0 in a config file — first to stdout, 
#then in-place with a backup. Concept: sed substitution,
# in-place editing. Hint: sed -i.bak.

file=$1

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <csvfile>" >&2
    exit 1
fi
if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a file" >&2
    exit 1
fi
echo "=== preview (stdout, file unchanged) ==="
sed 's/localhost/0.0.0.0/g' "$file"          # Part 1

echo "=== applying in place (backup: $file.bak) ==="
sed -i.bak 's/localhost/0.0.0.0/g' "$file"   # Part 2 — no echo, it has no output
echo "Done. Original saved as $file.bak"

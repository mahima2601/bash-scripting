#!/bin/bash

#Day 36. Write a backup script that tars a given directory into
# a timestamped archive in a backup folder, and deletes archives
# older than 7 days. Concept: tar, find -mtime, timestamping.

set -euo pipefail

# ---- 1. Validate input ----
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <directory>" >&2
    exit 1
fi

src=$1

if [[ ! -d "$src" ]]; then
    echo "Error: '$src' is not a directory" >&2
    exit 1
fi

# ---- 2. Build the archive path ----
backup_dir="backup"
timestamp=$(date +%Y%m%d_%H%M%S)
name=$(basename "$src")
archive="$backup_dir/${name}_${timestamp}.tar.gz"

mkdir -p "$backup_dir"

# ---- 3. Create the archive ----
tar -czf "$archive" "$src"
echo "Backup created: $archive"

# ---- 4. Delete archives older than 7 days ----
find "$backup_dir" -name "*.tar.gz" -mtime +7 -delete
echo "Old archives (7+ days) removed"

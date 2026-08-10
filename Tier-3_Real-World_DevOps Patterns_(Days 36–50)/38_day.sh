#!/bin/bash
set -euo pipefail

#Day 38. Add strict mode and a trap-based cleanup to a script that creates a temp directory, does work, and always removes the temp dir on exit (even on error or Ctrl-C). Concept: set -euo pipefail, trap cleanup EXIT, mktemp -d.

#!/bin/bash

# DDay 35. Write a script using getopts that accepts 
#-e <env>, -v (verbose), and -h (help) flags and acts 
#on them. Concept: proper argument parsing. Hint: this is a senior-level must-know.

usage() {
    cat <<USAGE
Usage: $0 [-e <env>] [-v] [-h]
  -e <env>   target environment (dev|staging|prod)
  -v         verbose output
  -h         show this help
USAGE
}

env=""
verbose=0

# leading ':' = we handle errors ourselves;  'e:' = -e needs an argument
while getopts ":e:vh" opt; do
    case "$opt" in
        e)  env="$OPTARG" ;;                                   # -e value → $OPTARG
        v)  verbose=1 ;;
        h)  usage; exit 0 ;;
        :)  echo "Error: -$OPTARG requires an argument" >&2; usage; exit 1 ;;
        \?) echo "Error: unknown option -$OPTARG" >&2; usage; exit 1 ;;
    esac
done
shift $((OPTIND - 1))          # drop parsed options; "$@" now = positional args

(( verbose )) && echo "[verbose on]"
if [[ -n "$env" ]]; then
    echo "Target environment: $env"
else
    echo "No environment set (use -e)"
fi
(( $# )) && echo "Leftover args: $*"

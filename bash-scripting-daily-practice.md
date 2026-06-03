# Bash Scripting — Daily Practice Question Bank

**For:** Senior DevOps Engineer interview prep
**Format:** One question per day, beginner → advanced
**Total:** 60 questions (~10 weeks at 1/day, with Sundays off)

---

## How to use this

1. Do **one question per day**. Don't skip ahead — the tiers build on each other.
2. Attempt it fully on your own first. Write the script, run it, break it, fix it.
3. Always run your finished script through `shellcheck` (`shellcheck myscript.sh`) and lint it.
4. When you're done (or stuck), **paste your attempt to me** and I'll review it, point out bugs, show the idiomatic/production version, and ask you a follow-up the way an interviewer would.
5. Mark each question done in the tracker at the bottom.

Each question lists the **concept** it tests and a **hint**. Solutions are intentionally NOT included — the point is to struggle a little, then have me review. That's where the real learning happens.

> Tip: keep all your scripts in a git repo (`bash-practice/`). It doubles as a portfolio you can show in interviews.

---

## Tier 1 — Fundamentals (Days 1–15)

**Day 1.** Write a script that prints "Hello, DevOps" and then prints the name of the user running it.
*Concept:* shebang, `echo`, environment variables. *Hint:* `$USER` or `whoami`.

**Day 2.** Write a script that takes your name as a command-line argument and greets you. If no argument is given, print a usage message and exit with a non-zero code.
*Concept:* positional parameters, exit codes. *Hint:* `$1`, `$#`, `exit 1`.

**Day 3.** Write a script that accepts two numbers as arguments and prints their sum, difference, product, and integer quotient.
*Concept:* arithmetic. *Hint:* `$(( ))`.

**Day 4.** Prompt the user to type a directory path, then print whether it exists, and if so whether it's readable and writable.
*Concept:* `read`, file test operators. *Hint:* `-d`, `-r`, `-w`.

**Day 5.** Write a script that checks if a given string argument is empty and prints an appropriate message either way.
*Concept:* string tests. *Hint:* `-z`, `-n`, always quote `"$1"`.

**Day 6.** Write a script that prints the current date in `YYYY-MM-DD` format and the current Unix timestamp.
*Concept:* command substitution, `date` formatting. *Hint:* `$(date +%F)`, `date +%s`.

**Day 7.** Write a script that takes a filename and reports whether it's a regular file, a directory, a symlink, or doesn't exist.
*Concept:* `if/elif/else`, file tests. *Hint:* `-f`, `-d`, `-L`, `-e`.

**Day 8.** Write a script that reads a number and prints whether it's positive, negative, or zero.
*Concept:* numeric comparison. *Hint:* `-gt`, `-lt`, `-eq`.

**Day 9.** Write a script that takes a username argument and checks whether that user exists on the system.
*Concept:* command exit status in conditionals. *Hint:* `id "$1" &>/dev/null`.

**Day 10.** Write a script that prints all its arguments, one per line, with their position number (e.g. `1: foo`).
*Concept:* iterating positional params. *Hint:* `$@`, `$#`, a counter.

**Day 11.** Write a script using a `case` statement that takes one of `start|stop|restart|status` and prints what it would do. Anything else prints usage.
*Concept:* `case`. *Hint:* this mirrors init-script structure.

**Day 12.** Write a script that checks whether a service (e.g. `nginx`) is active, using `systemctl`, and prints a clear up/down message.
*Concept:* exit codes from real commands. *Hint:* `systemctl is-active --quiet nginx`.

**Day 13.** Write a script that takes a file path and prints its size in human-readable form and its line count.
*Concept:* command substitution, combining tools. *Hint:* `du -h`, `wc -l`.

**Day 14.** Write a script that counts how many arguments it received and rejects the run if fewer than 2 are given.
*Concept:* argument validation. *Hint:* `[ "$#" -lt 2 ]`.

**Day 15.** Write a script that reads three numbers (as args) and prints the largest.
*Concept:* nested conditionals / comparison logic. *Hint:* compare pairwise.

---

## Tier 2 — Loops, Functions & Text Processing (Days 16–35)

**Day 16.** Print the numbers 1 to 10, each on its own line, using a `for` loop. Then do the same with a `while` loop.
*Concept:* both loop styles. *Hint:* `{1..10}`, `(( i++ ))`.

**Day 17.** Loop over all `.log` files in a directory and print each filename with its line count.
*Concept:* globbing in loops. *Hint:* `for f in *.log; do ... done`; handle the no-match case.

**Day 18.** Write a script that prints the multiplication table (1–10) for a number passed as an argument.
*Concept:* loops + arithmetic.

**Day 19.** Write a function `is_even` that returns success/failure (via exit code) for a number, and use it in a loop over 1–20.
*Concept:* functions, return-as-exit-code. *Hint:* `return 0` / `return 1`.

**Day 20.** Write a function `log()` that prints a message prefixed with a timestamp and a log level (INFO/WARN/ERROR passed as the first arg).
*Concept:* function arguments, reusable logging. *Hint:* you'll reuse this pattern constantly.

**Day 21.** Read a file line by line and print only lines longer than 80 characters, with their line numbers.
*Concept:* `while read` loop, `${#line}`. *Hint:* `while IFS= read -r line`.

**Day 22.** Given a log file, count how many lines contain "ERROR", "WARN", and "INFO" respectively.
*Concept:* `grep -c`. *Hint:* anchor your patterns.

**Day 23.** Extract all unique IP addresses from a web server access log and print them sorted by frequency (most frequent first).
*Concept:* `awk`/`grep` + `sort` + `uniq -c`. *Hint:* `sort | uniq -c | sort -rn`.

**Day 24.** Write a script that takes a CSV file and prints only the 1st and 3rd columns.
*Concept:* `awk` / `cut` with field separators. *Hint:* `awk -F, '{print $1, $3}'`.

**Day 25.** Use `sed` to replace every occurrence of `localhost` with `0.0.0.0` in a config file — first to stdout, then in-place with a backup.
*Concept:* `sed` substitution, in-place editing. *Hint:* `sed -i.bak`.

**Day 26.** Write a script that strips blank lines and comment lines (starting with `#`) from a config file and prints the result.
*Concept:* `grep -v` / `sed`. *Hint:* `grep -vE '^\s*(#|$)'`.

**Day 27.** Write a function that takes a full file path and prints the directory, the filename, the basename without extension, and the extension separately.
*Concept:* parameter expansion. *Hint:* `${path##*/}`, `${name%.*}`, `${name##*.}`.

**Day 28.** Loop over all running Kubernetes namespaces (`kubectl get ns`) and print the pod count in each.
*Concept:* looping over command output, parsing. *Hint:* careful with the header row.

**Day 29.** Write a script that retries a command up to N times with a 2-second pause between attempts, succeeding as soon as the command does.
*Concept:* retry loop. *Hint:* `for attempt in $(seq 1 "$N")`.

**Day 30.** Parse a date-stamped log and print only entries from the last 24 hours.
*Concept:* `awk` with date comparison or `date` arithmetic. *Hint:* `date -d '24 hours ago' +%s`.

**Day 31.** Write a script that takes a directory and prints the 5 largest files within it (recursively), with sizes.
*Concept:* `find` + `du` + `sort`. *Hint:* `find . -type f -exec du -h {} +`.

**Day 32.** Write a script that validates whether a string passed in is a valid IPv4 address.
*Concept:* regex matching with `[[ =~ ]]`. *Hint:* `BASH_REMATCH`, check each octet ≤ 255.

**Day 33.** Write a function that converts a number of seconds into `Xh Ym Zs` format.
*Concept:* arithmetic + functions. *Hint:* modulo `%`.

**Day 34.** Read a list of hostnames from a file and ping each once, printing reachable/unreachable.
*Concept:* loop + per-line action + exit codes. *Hint:* `ping -c1 -W1`.

**Day 35.** Write a script using `getopts` that accepts `-e <env>`, `-v` (verbose), and `-h` (help) flags and acts on them.
*Concept:* proper argument parsing. *Hint:* this is a senior-level must-know.

---

## Tier 3 — Real-World DevOps Patterns (Days 36–50)

**Day 36.** Write a backup script that tars a given directory into a timestamped archive in a backup folder, and deletes archives older than 7 days.
*Concept:* `tar`, `find -mtime`, timestamping. *Hint:* `find ... -mtime +7 -delete`.

**Day 37.** Write a disk-usage alert script: if any mounted filesystem is above 80% full, print a warning line for it.
*Concept:* `df` parsing with `awk`. *Hint:* strip the `%` before comparing.

**Day 38.** Add **strict mode** and a `trap`-based cleanup to a script that creates a temp directory, does work, and always removes the temp dir on exit (even on error or Ctrl-C).
*Concept:* `set -euo pipefail`, `trap cleanup EXIT`, `mktemp -d`.

**Day 39.** Write a script that prevents two copies of itself from running at once using a lockfile.
*Concept:* concurrency safety. *Hint:* `flock` or a PID lockfile with a trap.

**Day 40.** Write a health-check script that hits an HTTP endpoint and verifies it returns 200 within a timeout; exit non-zero otherwise.
*Concept:* `curl` with `-s -o /dev/null -w '%{http_code}'`, timeouts.

**Day 41.** Write a script that reads a `.env`-style file and exports all the variables into the current environment safely.
*Concept:* sourcing vs parsing, handling quotes/comments. *Hint:* don't blindly `source` untrusted files.

**Day 42.** Parse `kubectl get pods -o json` with `jq` to list all pods that are NOT in `Running` state, with their namespace and reason.
*Concept:* `jq` filtering. *Hint:* `jq -r '.items[] | select(...)'`.

**Day 43.** Write a script that takes a Docker image name and prints all its tags from a registry (or all local images matching a name).
*Concept:* `docker images` parsing / API calls.

**Day 44.** Write a log-rotation script: when a log exceeds a size threshold, rename it with a timestamp, gzip it, and truncate the original.
*Concept:* size checks, `gzip`, `: > file` truncation.

**Day 45.** Write a script that runs a command and logs both stdout and stderr to a timestamped log file while still showing output on the terminal.
*Concept:* redirection, `tee`, `2>&1`. *Hint:* `2>&1 | tee`.

**Day 46.** Write a script that pings N hosts **in parallel** and collects the results, limiting concurrency to 5 at a time.
*Concept:* background jobs, `wait`, or `xargs -P`. *Hint:* `xargs -P5 -I{}`.

**Day 47.** Write a templating script that takes a template file containing `${VAR}` placeholders and substitutes environment variables into it.
*Concept:* `envsubst` or `sed`. *Hint:* useful for generating k8s manifests.

**Day 48.** Write a script that watches a log file in real time and prints an alert line whenever "OutOfMemory" appears.
*Concept:* `tail -F` piped into a loop. *Hint:* `tail -Fn0 file | while read -r line`.

**Day 49.** Write a deployment helper that checks a list of prerequisites (commands installed, env vars set, cluster reachable) and fails fast with a clear list of what's missing.
*Concept:* validation, accumulating errors, `command -v`.

**Day 50.** Write a script that bumps a semantic version (`MAJOR.MINOR.PATCH`) — accepting `major|minor|patch` as an argument — reading from and writing to a `VERSION` file.
*Concept:* parsing, arithmetic, file I/O. *Hint:* `IFS=. read -r major minor patch < VERSION`.

---

## Tier 4 — Senior / Interview-Level (Days 51–60)

**Day 51.** Implement exponential backoff with jitter for a retried command (delays 1s, 2s, 4s, 8s… capped at 30s, plus a small random offset).
*Concept:* backoff algorithm, `$RANDOM`, arithmetic.

**Day 52.** Write a script that processes a large file line-by-line in a memory-efficient way and explain (in comments) why `for line in $(cat file)` is the wrong approach.
*Concept:* word splitting pitfalls, `while IFS= read -r`. *Interview favorite.*

**Day 53.** Use an **associative array** to count occurrences of each HTTP status code in an access log, then print a sorted summary.
*Concept:* `declare -A`, associative array iteration.

**Day 54.** Write a script that safely handles filenames containing spaces and newlines while iterating over `find` results.
*Concept:* `find -print0` + `read -d ''`. *Interview favorite.*

**Day 55.** Demonstrate and explain `${PIPESTATUS[@]}`: write a pipeline where the first command fails and show how to detect it even though the pipeline "succeeds".
*Concept:* pipeline exit codes — a classic gotcha senior interviewers probe.

**Day 56.** Write a self-documenting script with a `--help` flag, proper `getopts`, strict mode, a logging function, error trapping, and a `main` function — production-grade structure.
*Concept:* putting it all together. This is your template script going forward.

**Day 57.** Write a script that monitors a process by name and restarts it if it dies, with a max restart count to avoid crash loops.
*Concept:* process management, `pgrep`, state tracking.

**Day 58.** Write a function library (`lib.sh`) with `log`, `die`, `require_cmd`, and `confirm` functions, then a main script that sources and uses it.
*Concept:* modular scripts, `source`, reusable code.

**Day 59.** Write a script that diffs two environments by comparing the sorted output of two commands (e.g. installed package lists) and prints what's only in each.
*Concept:* `comm`, `diff`, process substitution `<( )`.

**Day 60.** **Capstone:** Write a mini deployment orchestrator that: validates prerequisites, takes an environment flag, pulls/templates a config, runs a deploy command with retries and logging, health-checks the result, and rolls back on failure — all with strict mode, traps, and clean logging.
*Concept:* everything combined. This is essentially a real script you'd write at work.

---

## Common interview gotchas to internalize as you go

- Always quote your variables: `"$var"`, `"$@"` — unquoted variables cause word-splitting bugs.
- `[[ ]]` over `[ ]` in Bash (safer, supports `=~` and `&&`).
- `set -euo pipefail` at the top of every serious script — know what each flag does and its caveats.
- `for line in $(cat file)` is wrong — use `while IFS= read -r line; do ... done < file`.
- A pipeline's exit code is the last command's unless you check `PIPESTATUS`.
- `$(command)` over backticks — nestable and clearer.
- Difference between `$*` and `$@`, and why quoting changes their behavior.
- `local` in functions to avoid leaking variables to global scope.

---

## Progress tracker

| Day | Done | Day | Done | Day | Done | Day | Done |
|-----|------|-----|------|-----|------|-----|------|
| 1   | ☐    | 16  | ☐    | 31  | ☐    | 46  | ☐    |
| 2   | ☐    | 17  | ☐    | 32  | ☐    | 47  | ☐    |
| 3   | ☐    | 18  | ☐    | 33  | ☐    | 48  | ☐    |
| 4   | ☐    | 19  | ☐    | 34  | ☐    | 49  | ☐    |
| 5   | ☐    | 20  | ☐    | 35  | ☐    | 50  | ☐    |
| 6   | ☐    | 21  | ☐    | 36  | ☐    | 51  | ☐    |
| 7   | ☐    | 22  | ☐    | 37  | ☐    | 52  | ☐    |
| 8   | ☐    | 23  | ☐    | 38  | ☐    | 53  | ☐    |
| 9   | ☐    | 24  | ☐    | 39  | ☐    | 54  | ☐    |
| 10  | ☐    | 25  | ☐    | 40  | ☐    | 55  | ☐    |
| 11  | ☐    | 26  | ☐    | 41  | ☐    | 56  | ☐    |
| 12  | ☐    | 27  | ☐    | 42  | ☐    | 57  | ☐    |
| 13  | ☐    | 28  | ☐    | 43  | ☐    | 58  | ☐    |
| 14  | ☐    | 29  | ☐    | 44  | ☐    | 59  | ☐    |
| 15  | ☐    | 30  | ☐    | 45  | ☐    | 60  | ☐    |

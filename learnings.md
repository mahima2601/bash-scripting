# My Bash Learnings

A running log of what I learn each day. One section per day.
The actual code for each day lives in `N_day.sh`; this file is the *theory*.
**Day 0** below is the foundations primer — everything worth knowing *before*
writing your first script.

---

## Day 0 — Foundations (learn these before scripting)

> The goal of Day 0 is the **mental model** and the **vocabulary**. You don't
> need to master everything here — just be comfortable enough that the later
> days make sense. Deep dives are linked to their days.

### Section 1 — Shell, terminal, and Bash: what they actually are

Three words people mix up:

| Term         | What it is                                                         |
|--------------|--------------------------------------------------------------------|
| **Terminal** | The *window/app* you type into (Terminal.app, iTerm, VS Code term).|
| **Shell**    | The *program* that reads your commands and runs them.              |
| **Bash**     | One *specific* shell (Bourne Again SHell). Others: `zsh`, `sh`, `fish`. |

Think of it like a car: the **terminal** is the windshield you look through, the
**shell** is the engine that does the work, and **Bash** is one brand of engine.

**A shell does two jobs:**
1. **Interactive** — you type commands one at a time and it responds.
2. **Scripting** — you put many commands in a file (`.sh`) and run them together.

Bash scripting is just **writing down the same commands** you'd type by hand, so
the computer can repeat them reliably. If you can do it in the terminal, you can
script it.

> ⚠️ macOS note: your *login* shell is `zsh`, and the `bash` on macOS is an old
> **3.2** version. Real Linux servers (where DevOps work happens) run bash 4 or
> 5. A few features (associative arrays — Day 53, `${var,,}` lowercasing) need
> bash 4+. For learning, install a modern bash with `brew install bash`.

### Section 2 — The filesystem and paths

Linux organizes everything in a **tree** starting at `/` (the "root").

```
/                 <- root of everything
├── home/         <- users' home directories (on macOS: /Users/)
│   └── mahima/   <- your home, shortcut: ~
├── etc/          <- system config files
├── var/          <- logs, variable data (/var/log)
├── tmp/          <- temporary files
└── usr/          <- installed programs (/usr/bin)
```

**Two ways to name a location:**

| Path type    | Starts with | Meaning                          | Example              |
|--------------|-------------|----------------------------------|----------------------|
| **Absolute** | `/`         | full address from root           | `/Users/mahima/a.sh` |
| **Relative** | not `/`     | from where you *currently* are   | `scripts/a.sh`       |

**Special shortcuts you'll use constantly:**

| Symbol | Means                          |
|--------|--------------------------------|
| `~`    | your home directory            |
| `.`    | the **current** directory      |
| `..`   | the **parent** directory (one up) |
| `-`    | the **previous** directory (`cd -`) |
| `/`    | the root directory             |

```bash
cd /var/log        # absolute — go exactly there
cd ..              # up one level
cd ~               # home
cd -               # back to where I just was
pwd                # "print working directory" — where am I?
```

### Section 3 — Essential Linux commands

You must be fluent with these before scripting — a script is just these
commands stacked up.

**Navigation & looking around**

| Command | What it does                        | Common use          |
|---------|-------------------------------------|---------------------|
| `pwd`   | print current directory             | `pwd`               |
| `ls`    | list files                          | `ls -la` (all + details) |
| `cd`    | change directory                    | `cd /tmp`           |
| `tree`  | show directory as a tree            | `tree -L 2`         |

**Working with files & directories**

| Command | What it does                        | Example                    |
|---------|-------------------------------------|----------------------------|
| `touch` | create an empty file / update time  | `touch app.log`            |
| `mkdir` | make a directory                    | `mkdir -p a/b/c` (nested)  |
| `cp`    | copy                                | `cp a.txt b.txt`           |
| `mv`    | move **or rename**                  | `mv old.txt new.txt`       |
| `rm`    | remove (⚠️ no undo!)                | `rm file`, `rm -r dir`     |
| `ln -s` | symbolic link (shortcut)            | `ln -s target link`        |

> ⚠️ `rm -rf` deletes recursively with **no confirmation and no trash**. Double-
> check the path every single time. There is no undo.

**Viewing file contents**

| Command | What it does                             | Example              |
|---------|------------------------------------------|----------------------|
| `cat`   | dump whole file                          | `cat file.txt`       |
| `less`  | scroll a file page by page (`q` to quit) | `less big.log`       |
| `head`  | first lines (default 10)                 | `head -n 20 file`    |
| `tail`  | last lines; `-f` follows live            | `tail -f app.log`    |
| `wc`    | count lines/words/chars                  | `wc -l file` (lines) |

**Searching & filtering** (the DevOps bread-and-butter)

| Command | What it does                              | Example                    |
|---------|-------------------------------------------|----------------------------|
| `grep`  | find lines matching a pattern             | `grep "ERROR" app.log`     |
| `find`  | find files by name/type/age               | `find . -name "*.sh"`      |
| `sort`  | sort lines                                | `sort names.txt`           |
| `uniq`  | collapse/count duplicate lines            | `sort f \| uniq -c`        |
| `cut`   | slice columns                             | `cut -d, -f1 data.csv`     |
| `awk`   | field-based text processing               | `awk '{print $1}' file`    |
| `sed`   | stream editor (find/replace)              | `sed 's/a/b/g' file`       |

**Finding a directory specifically**

| Command                        | Finds a directory by…       |
|--------------------------------|-----------------------------|
| `find . -type d -name "logs"`  | name, walking the tree      |
| `find / -type d -name "x" 2>/dev/null` | name, from root (silence errors) |
| `mdfind -name "logs"`          | Spotlight index (**macOS**) |
| `locate logs`                  | prebuilt index (**Linux**)  |
| `ls -d */`                     | listing dirs in the current folder |
| `pwd`                          | telling you where you are now |

> `-type d` = **directories only** (`-type f` = files). `2>/dev/null` throws away
> "permission denied" noise (Day 2 §5). Same tools apply to Day 17 (looping over
> files) and Day 31 (finding the largest files).

**System & process info**

| Command    | What it does                        |
|------------|-------------------------------------|
| `whoami`   | your username (Day 1 used this)     |
| `date`     | current date/time                   |
| `df -h`    | disk space, human-readable          |
| `du -h`    | directory sizes                     |
| `ps aux`   | running processes                   |
| `top`      | live process monitor                |
| `kill PID` | stop a process                      |
| `chmod`    | change permissions (Section 4)      |
| `man CMD`  | manual/help for a command           |

> The single most useful pattern: **pipe** commands together with `|` to build
> power from small tools — `cat access.log | grep 404 | wc -l` = "how many 404s?"
> (Pipes explained in Section 7.)

### Section 4 — File permissions (`rwx`, `chmod`)

Every file has permissions for three groups of people. Run `ls -l`:

```
-rwxr-xr--  1 mahima staff  54 Jun 3 file.sh
 └┬┘└┬┘└┬┘
  │  │  └── others (everyone else):  r-- = read only
  │  └───── group:                   r-x = read + execute
  └──────── owner (you):             rwx = read + write + execute
```

Each slot is three bits — **r**ead, **w**rite, e**x**ecute:

| Letter | On a file            | On a directory                  |
|--------|----------------------|----------------------------------|
| `r`    | read its contents    | list what's inside               |
| `w`    | modify it            | create/delete files inside       |
| `x`    | **run** it as a program | `cd` into it                  |

**The octal (number) shortcut** — add the values in each group:

| Permission | r=4 | w=2 | x=1 | Total |
|------------|-----|-----|-----|-------|
| `rwx`      | 4   | 2   | 1   | **7** |
| `rw-`      | 4   | 2   | 0   | **6** |
| `r-x`      | 4   | 0   | 1   | **5** |
| `r--`      | 4   | 0   | 0   | **4** |

So `chmod 755 file` = `rwx` for owner, `r-x` for group, `r-x` for others — the
classic "executable script" permission.

```bash
chmod +x script.sh     # add execute (simplest, most common)
chmod 755 script.sh    # same result via octal
chmod 644 notes.txt    # rw-r--r-- : owner edits, others read (normal file)
```

> This is **why** `./script.sh` needs `chmod +x` first (Day 1): without the `x`
> bit, the system refuses to run it as a program.

### Section 5 — Anatomy of a shell script

A script is just a text file of commands. Three things make it "a script":

```bash
#!/bin/bash          # 1. the SHEBANG — must be the VERY first line
echo "Hello"         # 2. your commands, top to bottom
```

1. **The shebang `#!/bin/bash`** — tells the system which interpreter to use.
   It **must** be line 1, character 1 (the kernel reads the first two bytes `#!`).
   Putting a comment or blank line above it **breaks** it.
2. **Make it executable** — `chmod +x script.sh` (Section 4).
3. **Run it** — three ways (full detail in Day 1):

| Command            | Runs in        | Needs `+x`? | Uses shebang? |
|--------------------|----------------|-------------|---------------|
| `./script.sh`      | child subshell | yes         | yes           |
| `bash script.sh`   | child subshell | no          | no            |
| `source script.sh` | current shell  | no          | no            |

> `#` starts a **comment** — everything after it on the line is ignored (except
> the shebang, which is special). Use comments to explain *why*, not *what*.

### Section 6 — Variables and quoting

```bash
name="Mahima"        # NO spaces around = ! (name = "x" is an error)
echo "$name"         # use $ to read it back -> Mahima
echo "${name}"       # braces when you need a clear boundary
```

| Rule                          | Why                                            |
|-------------------------------|------------------------------------------------|
| No spaces around `=`          | `x = 5` is read as a *command* `x` with args    |
| `$name` reads the value       | without `$` it's just the literal text "name"   |
| **Always quote:** `"$name"`   | prevents word-splitting when the value has spaces |

**Quoting — the #1 beginner bug (and interview topic):**

| Quote     | Effect                                         | `echo` of `x="a b"` |
|-----------|------------------------------------------------|---------------------|
| `"..."`   | expands variables, keeps spaces intact         | `a b`               |
| `'...'`   | **literal** — no `$` expansion at all           | `$x`                |
| no quotes | expands **and** word-splits (danger!)           | `a b` (as 2 words)  |

```bash
x="a b"
echo "$x"    # a b   (one argument — correct)
echo '$x'    # $x    (single quotes = literal)
echo $x      # a b   (but passed as TWO words — bugs!)
```

Rule of thumb: **double-quote every variable** unless you have a specific reason
not to. (This connects to Day 2 §1 quoting and Day 3 §4 validation.)

### Section 7 — Input/output: streams, redirection, pipes

Every command has **three streams** (you'll see these everywhere):

| # | Name   | Default | Purpose                    |
|---|--------|---------|----------------------------|
| 0 | stdin  | keyboard| where input comes in       |
| 1 | stdout | screen  | normal output              |
| 2 | stderr | screen  | errors / warnings          |

**Redirection — send a stream somewhere else:**

| Symbol      | Meaning                                  |
|-------------|------------------------------------------|
| `>`         | stdout → file (**overwrite**)            |
| `>>`        | stdout → file (**append**)               |
| `2>`        | stderr → file                            |
| `&>`        | **both** stdout+stderr → file            |
| `< file`    | feed file **into** stdin                 |
| `2>&1`      | send stderr to wherever stdout is going  |

```bash
echo "hi" > out.txt        # write (replaces contents)
echo "more" >> out.txt     # add to the end
command 2> errors.txt      # capture only errors
command &> /dev/null       # silence everything (Day 2 §5)
```

**Pipes `|` — the killer feature.** Connect one command's stdout to the next
command's stdin, building a chain:

```bash
cat access.log | grep "404" | wc -l      # count 404 errors
ps aux | grep nginx                       # find nginx processes
ls -l | sort -k5 -n | tail -5             # 5 biggest files
```

This is the Unix philosophy: **small tools, each doing one thing, combined.**
(Deep dives: streams & `>&2` in Day 2 §4, `/dev/null` in Day 2 §5.)

### Section 8 — The building blocks (preview + index)

These are the pieces you'll assemble in every script. Each has a full section on
the day it's introduced — this is your **map**:

**Conditionals (`if/else`)** — do something *only if* a condition holds:

```bash
if [ "$age" -ge 18 ]; then
    echo "adult"
elif [ "$age" -ge 13 ]; then
    echo "teen"
else
    echo "child"
fi
```
→ Full detail: **Day 2 §2**.

**Brackets** — the confusing part, so here's the one-liner (full guide **Day 3 §7**):

| Bracket   | Use for                          |
|-----------|----------------------------------|
| `[[ ]]`   | string/file tests (your default) |
| `(( ))`   | number tests & math actions      |
| `$(( ))`  | math you want the **value** of   |
| `$( )`    | capture a command's **output**   |
| `${ }`    | a **variable's** value           |

**Arithmetic** — Bash math is **integer only** (`10/3 = 3`):

```bash
sum=$(( 5 + 3 ))       # 8
echo $(( 10 % 3 ))     # 1 (remainder)
```
→ Full detail: **Day 3 §1–2**.

**Loops** — repeat an action:

```bash
for i in 1 2 3; do echo "$i"; done       # for loop
for f in *.log; do echo "$f"; done        # loop over files

while [ "$n" -lt 5 ]; do                   # while loop
    echo "$n"; n=$(( n + 1 ))
done
```
→ Full detail: coming in **Day 16**.

**Functions** — name a reusable block:

```bash
greet() {
    echo "Hello, $1"     # $1 = first argument to the function
}
greet "Mahima"           # call it
```
→ Full detail: coming in **Day 19–20**.

### Section 9 — Getting help & debugging

You will not memorize everything — knowing **how to look things up** is the real
skill.

| Tool                | What it does                                  |
|---------------------|-----------------------------------------------|
| `man ls`            | full manual for a command (`q` to quit)       |
| `ls --help`         | quick help (Linux; macOS often lacks `--help`)|
| `type cmd`          | is it a builtin, alias, or program?           |
| `which cmd`         | path to the program                           |
| `help if`           | help for Bash **builtins** (`if`, `cd`, etc.) |

**Debugging your scripts:**

```bash
bash -x script.sh      # TRACE: prints each line as it runs (super useful)
bash -n script.sh      # syntax-check WITHOUT running it
set -x                 # turn tracing on partway through a script
set +x                 # turn it back off
```

**`shellcheck`** — a linter that catches bugs before you run. Install with
`brew install shellcheck`, then `shellcheck script.sh`. It flags unquoted
variables, wrong brackets, and the exact gotchas in these notes. **Use it on
every script** — the practice bank recommends it too.

### Section 10 — Strict mode (a habit to start early)

Serious scripts open with this line. You'll understand each flag by Day 38, but
start using it now:

```bash
set -euo pipefail
```

| Flag          | Effect                                                    |
|---------------|-----------------------------------------------------------|
| `set -e`      | exit immediately if any command fails                     |
| `set -u`      | error on use of an **undefined** variable (catches typos) |
| `set -o pipefail` | a pipeline fails if **any** stage fails, not just the last |

Without these, a failing command is silently ignored and the script keeps going
with bad data — the source of many real outages.

#### Day 0 key takeaways
- Terminal = window, **shell** = engine, **Bash** = one engine. A script is just
  typed commands saved in a file.
- Master `cd ls pwd cat grep find` and pipes `|` **before** scripting.
- `rwx` = 4/2/1; `chmod +x` is what lets `./script.sh` run.
- The shebang `#!/bin/bash` must be **line 1**.
- **Quote your variables:** `"$var"`.
- Three streams: stdin(0), stdout(1), stderr(2); redirect with `> >> 2> &>`.
- Look things up with `man`; debug with `bash -x`; lint with `shellcheck`.

---

## Day 1 — Running a script vs. sourcing it

**Execution forks a subshell; sourcing runs in-place.** Sourcing is how things
like `~/.bashrc`, `nvm`, and `.env` loaders work — they *need* their variables
to persist in your current shell.

| How you run it     | Runs in         | Affects terminal's variables? |
|--------------------|-----------------|-------------------------------|
| `./day_1.sh`       | child subshell  | No                            |
| `bash day_1.sh`    | child subshell  | No                            |
| `source day_1.sh`  | current shell   | **Yes**                       |
| `. day_1.sh`       | current shell   | **Yes**                       |

(`.` is just the POSIX short form of `source` — identical behaviour.)

### Extra nuances (interview-worthy)
- A **subshell** gets a *copy* of the parent's environment. Variables it sets,
  `cd`s it does, etc. vanish when it exits — that's why `./script.sh` can't
  change your current directory.
- `export`ed variables are *inherited* by the child (read access), but the
  child still can't push changes back up to the parent.
- `./day_1.sh` needs the **execute permission** (`chmod +x`) and uses the
  script's shebang (`#!/bin/bash`) to pick the interpreter. `bash day_1.sh`
  ignores the shebang and doesn't need `+x`.
- `exit` inside a **sourced** script will close your *current* shell (it runs
  in-place!). Use `return` in scripts meant to be sourced.

---

## Day 2

### Section 1 — Command-line arguments (positional parameters)

In Bash, command-line arguments are captured automatically using **positional
parameters** like `$1`, `$2`, `$3` — the number is the position of the argument
passed on the command line.

#### Special argument variables

| Variable      | Meaning                                                        |
|---------------|---------------------------------------------------------------|
| `$0`          | Name of the script being executed.                            |
| `$1` … `$9`   | The first nine command-line arguments.                        |
| `${10}` and up| Arguments past the ninth must be wrapped in curly braces.     |
| `$#`          | Total number of arguments passed.                             |
| `$@`          | All arguments as a list/array — **best for looping**.         |
| `$*`          | All arguments combined into a single string.                  |

#### Key takeaways
- Always **quote** them: `"$1"`, `"$@"` — unquoted values break on spaces.
- `"$@"` vs `"$*"`: `"$@"` keeps each argument separate; `"$*"` joins them
  into one string. Use `"$@"` when looping.
- Validate input with `$#` and exit non-zero on bad input: `exit 1`.

#### Method 1: Basic positional parameters (best for simple scripts)

If you just need a few explicit inputs, read them directly using numbers.

```bash
#!/bin/bash

# Assign to descriptive variables for readability
FIRST_NAME="$1"
LAST_NAME="$2"

echo "The script name is: $0"
echo "Hello, $FIRST_NAME $LAST_NAME!"
echo "Total arguments passed: $#"
```

**Execution:**

```bash
$ ./script.sh John Doe
The script name is: ./script.sh
Hello, John Doe!
Total arguments passed: 2
```

> Note: Always use double quotes around variables (e.g. `"$1"`) to prevent
> issues if an argument contains spaces.

#### Method 2: Looping through a variable number of arguments

If your script handles an unknown or variable number of arguments (like a list
of files), loop over the `"$@"` list.

```bash
#!/bin/bash

echo "Processing $# items..."

# Loop through each argument individually
for item in "$@"; do
    echo "Item: $item"
done
```

**Execution:**

```bash
$ ./script.sh file1.txt file2.txt file3.txt
Processing 3 items...
Item: file1.txt
Item: file2.txt
Item: file3.txt
```

### Section 2 — Conditionals: how `if/else` works

Every conditional block **starts with `if`**, introduces actions with **`then`**,
and **closes with `fi`** (`if` spelled backward).

**1. Basic `if`** — runs code only if the condition is true.

```bash
if [ condition ]; then
    # Code runs if condition is true
fi
```

**2. `if-else`** — a fallback block when the condition is false.

```bash
if [ condition ]; then
    # Code runs if condition is true
else
    # Code runs if condition is false
fi
```

**3. `if-elif-else`** — handle multiple conditions without deep nesting.

```bash
if [ condition1 ]; then
    # Runs if condition1 is true
elif [ condition2 ]; then
    # Runs if condition1 is false AND condition2 is true
else
    # Runs if all previous conditions fail
fi
```

#### Brackets and tests

The brackets you choose decide how the condition is processed:

- **Single brackets `[ ... ]`** — an alias for the classic `test` command.
  Spaces are **strictly required** after `[` and before `]`.
- **Double brackets `[[ ... ]]`** — an enhanced Bash-specific keyword. Safer:
  it prevents word splitting and supports regex (`=~`) and wildcards. Prefer
  this in Bash.
- **Double parentheses `(( ... ))`** — used **exclusively** for math and integer
  comparisons.

### Section 3 — Common Bash operators

#### Number comparisons (inside `[ ]` / `[[ ]]`)

Numeric tests use **flag-based** operators, not math symbols.

| Operator | Meaning                  | Example              |
|----------|--------------------------|----------------------|
| `-eq`    | Equal to                 | `[ "$a" -eq "$b" ]`  |
| `-ne`    | Not equal to             | `[ "$a" -ne "$b" ]`  |
| `-gt`    | Greater than             | `[ "$a" -gt 10 ]`    |
| `-lt`    | Less than                | `[ "$a" -lt "$b" ]`  |
| `-ge`    | Greater than or equal to | `[ "$a" -ge "$b" ]`  |
| `-le`    | Less than or equal to    | `[ "$a" -le "$b" ]`  |

> Note: Inside double parentheses `(( a > b ))` you can use the standard math
> symbols `>`, `<`, `==` directly.

#### String comparisons

Always wrap string variables in double quotes so the script doesn't break when a
variable is empty.

- `=` or `==` — true if the strings match.
- `!=` — true if the strings do **not** match.
- `-z` — true if the string is empty.
- `-n` — true if the string is **non**-empty.

#### File checks

- `-e` — true if the file or directory **exists**.
- `-f` — true if it exists and is a **regular file** (not a folder).
- `-d` — true if the path is a **directory**.
- `-r` — true if the path is **readable**.
- `-w` — true if the path is **writable**.
- `-x` — true if the path is **executable** (mirrors the `x` bit, Day 0 §4).
- `-L` — true if the path is a **symlink** (also `-h`). Unlike the others it
  checks the **link itself** and does **not** follow it to the target (Day 7).
- `-s` — true if the file exists and is **not empty** (size > 0).

> These are exactly what **Day 4** needs — "does it exist? (`-d`) is it readable?
> (`-r`) writable? (`-w`)". Always quote the path: `[[ -d "$path" ]]`, since a
> user might type a path containing spaces.

#### Complete practical example

Combines numeric evaluation, string/file checks, and validation:

```bash
#!/bin/bash

# 1. Numerical evaluation using double parentheses
SCORE=85

if (( SCORE >= 90 )); then
    echo "Grade: A"
elif (( SCORE >= 80 )); then
    echo "Grade: B"
else
    echo "Grade: C"
fi

# 2. String & file check using double brackets
FILE_PATH="./config.json"

if [[ -f "$FILE_PATH" ]]; then
    echo "The file exists."
else
    echo "Error: Configuration file is missing!"
fi
```

> ⚠️ Gotcha: the source for this example had `if (( SCORE >= 90 ]]; then` —
> that's **invalid** because it opens with `((` but closes with `]]`. Brackets
> must match: `(( ... ))`, `[[ ... ]]`, or `[ ... ]`. Mixing them is a syntax
> error.

### Section 4 — Redirecting errors with `>&2` (stdout vs stderr)

Think of every script as a machine with **two output hoses**:

| Number | Name   | Purpose                                  |
|--------|--------|------------------------------------------|
| `0`    | stdin  | where input comes in                     |
| `1`    | stdout | **normal results** go out here           |
| `2`    | stderr | **errors / warnings / usage** go out here|

These numbers are called **file descriptors**. By default *both* stdout and
stderr spray onto your screen, so they look like one thing — but they're two
separate streams, and you can point each one somewhere different.

#### What `>&2` means

`>&2` means **"send this output to file descriptor 2 (stderr)"**. So:

```bash
echo "Usage: $0 <name>" >&2     # goes to the ERROR hose, not the normal one
```

#### Why it matters — a hands-on example

Make a tiny test script:

```bash
cat > test.sh << 'EOF'
#!/bin/bash
echo "This is NORMAL output"
echo "This is an ERROR message" >&2
EOF
chmod +x test.sh
```

Run it plainly — both lines appear, because both hoses point at the screen:

```bash
$ ./test.sh
This is NORMAL output
This is an ERROR message
```

Now capture **only stdout** into a file. The `>` symbol redirects hose 1 only:

```bash
$ ./test.sh > output.txt
This is an ERROR message        # still on screen! stderr was NOT redirected
```

Look inside the file — the error is **not** there:

```bash
$ cat output.txt
This is NORMAL output
```

The two hoses went to two different places. 🎯 Clean up: `rm test.sh output.txt`

#### Connect it to the Day 2 script

If the script's real job is to produce a greeting you might save to a file:

```bash
$ ./2_day.sh John > greeting.txt     # greeting.txt = "Hello, John!"  ✅
```

Now forget the name:

- **Usage message uses `>&2`** → it rides the error hose, so `>` doesn't capture
  it. You see the error on screen, and `greeting.txt` stays clean. ✅
- **Usage message does NOT use `>&2`** → it rides the normal hose, gets captured
  by `>`, and lands *inside* `greeting.txt`. Your screen shows nothing, you think
  it worked, but the file is polluted with an error message. ❌

#### Rule of thumb
- **Real output → stdout** (the default, no redirect needed).
- **Errors, warnings, usage, progress logs → stderr** (`>&2`).

This is why in a pipeline like `kubectl get pods | grep Running`, only the actual
data flows through the pipe — diagnostic noise on stderr doesn't contaminate it.
A small habit that separates clean, composable scripts from messy ones.

### Section 5 — `/dev/null` and silencing output

#### The three redirect variants

| Redirect       | Meaning                          |
|----------------|----------------------------------|
| `> /dev/null`  | trash **stdout** only            |
| `2> /dev/null` | trash **stderr** only            |
| `&> /dev/null` | trash **both** stdout and stderr |

Now take this command apart into two pieces:

```bash
./2_day.sh > /dev/null
```

- **`/dev/null`** is the **"trash can" of Linux** — a special file that throws
  away anything sent to it. Write a gigabyte to it and it just vanishes. Nothing
  is stored, nothing comes back. It's a black hole.
- **`>`** (from Section 4) redirects **stdout** (hose 1, normal output).

So `./2_day.sh > /dev/null` means: **"run the script and throw away its normal
output."** stdout disappears into the trash — but **stderr (hose 2) is
untouched**, so any error messages still appear on your screen.

#### Why this is a great test

Because `>` only trashes stdout, anything left on your screen *must* have come
from stderr. Run the Day 2 script with no argument:

```bash
$ ./2_day.sh > /dev/null
pls run the script like this- ./2_day.sh <name>
```

The usage message still appears — which **proves** it's correctly going to
stderr (`>&2`). If it were going to stdout, `>` would have trashed it too.

#### Where you'll use `/dev/null` in real DevOps work

Often you don't care about a command's *output* — only whether it **succeeded or
failed** (its exit code). So you silence the output to keep scripts quiet:

```bash
# Check if a user exists — we don't want the output, just the result
if id "deploy" &>/dev/null; then
    echo "User exists"
fi

# Check if nginx is installed without printing its path
if command -v nginx > /dev/null; then
    echo "nginx is installed"
fi
```

`id "deploy" &>/dev/null` runs the check **completely silently**, and the `if`
just reads its exit code. You'll write this pattern constantly in health checks,
prerequisite validators, and conditionals — it's exactly what Day 9 (checking if
a user exists) needs.

### Section 6 — Heredocs (`<< EOF`) for writing multi-line files

A **heredoc** ("here-document") lets you feed a **block of multi-line text** into
a command, instead of typing one line at a time. You'll use it constantly to
generate YAML manifests and config files.

#### Anatomy of the command

```bash
cat > my_app.yaml << "EOF"
line one
line two
EOF
```

| Part            | Meaning                                                       |
|-----------------|---------------------------------------------------------------|
| `cat`           | the command that will receive the text                        |
| `> my_app.yaml` | redirect `cat`'s output into this file (the `>` you know)      |
| `<<`            | the **heredoc operator**: "everything that follows is input"  |
| `EOF`           | the **marker** for where the text starts and ends             |
| middle lines    | your actual content                                           |
| final `EOF`     | the **closing marker** — "the text stops here"                |

Bash reads everything between the opening `<< EOF` and the closing `EOF`, and
pipes it into `cat`, which writes it to the file.

#### `EOF` is just a label, not a magic word

`EOF` means "End Of File" by convention, but **any word works** — the only rules
are: the closing marker must **match** the opening one, and must sit **alone on
its own line** with nothing before or after it.

```bash
cat > test.txt << END_OF_CONFIG
line one
line two
END_OF_CONFIG
```

This works identically. People just use `EOF` out of habit.

#### Why use it? Readability

Without a heredoc, a multi-line file is clumsy:

```bash
echo "line one" > test.txt
echo "line two" >> test.txt
echo "line three" >> test.txt
```

With a heredoc, it's one clean block:

```bash
cat > test.txt << EOF
line one
line two
line three
EOF
```

#### The important part — quoted vs unquoted marker

The quotes around the marker control whether Bash **expands variables and
commands** inside the heredoc.

**Unquoted `EOF`** → variables and `$(...)` **are expanded**:

```bash
name="Mahima"
cat << EOF
Hello $name
Today is $(date +%F)
EOF
```
Output:
```
Hello Mahima
Today is 2026-06-16
```

**Quoted `"EOF"`** → everything is taken **literally**, no expansion:

```bash
name="Mahima"
cat << "EOF"
Hello $name
Today is $(date +%F)
EOF
```
Output:
```
Hello $name
Today is $(date +%F)
```

#### Why this matters for DevOps

When generating config files you often **want** substitution — e.g. injecting an
environment name or replica count into a manifest, so use **unquoted** `EOF`:

```bash
ENV="production"
REPLICAS=3

cat > deployment.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-$ENV
spec:
  replicas: $REPLICAS
EOF
```

But if the file genuinely contains dollar signs you want kept **literal** — like
a script using `$1`, or a config with `${VAR}` placeholders meant to be
substituted *later* — use **quoted** `"EOF"` to protect them. That's exactly the
Day 47 question (templating manifests).

#### Rule to remember
- `<< EOF` → **"fill in my variables"** (expand)
- `<< "EOF"` → **"leave everything exactly as I typed it"** (literal)

### Section 7 — Redirection operators: `>` `2>` `&>` `>&2` `2>&1`

These five look almost identical but do different things. One rule unlocks all of
them. (Builds on §4 stdout/stderr and §5 `/dev/null`.)

#### The one rule

> **Without `&`, the target is a _filename_. With `&`, the target is a
> _file-descriptor number_.**

So `2>file` sends errors to a file literally named `file`, but `2>&1` sends
errors to **wherever fd 1 (stdout) is currently pointing**. The `&` means "the
thing after me is a stream, not a filename."

Recall the streams: **stdout = fd 1** (normal output), **stderr = fd 2** (errors).

#### The five operators

| Syntax  | Long form   | Meaning                            | Typical use            |
|---------|-------------|------------------------------------|------------------------|
| `>`     | `1>`        | stdout → a **file** (overwrite)    | `cmd > out.txt`        |
| `2>`    | `2>`        | stderr → a **file**                | `cmd 2> err.txt`       |
| `&>`    | `>f 2>&1`   | **both** stdout+stderr → a file    | `cmd &> all.log`       |
| `>&2`   | `1>&2`      | stdout → **wherever stderr goes**  | `echo "oops" >&2`      |
| `2>&1`  | `2>&1`      | stderr → **wherever stdout goes**  | `cmd > log 2>&1`       |

#### When to use which (with examples)

| Goal                                    | Use this                     |
|-----------------------------------------|------------------------------|
| Save normal output to a file (overwrite)| `cmd > out.txt`              |
| **Append** instead of overwriting       | `cmd >> out.txt`             |
| Capture **only errors**                 | `cmd 2> err.txt`             |
| Print **your own** error/usage message  | `echo "Usage: ..." >&2`      |
| Log **everything** (output + errors)    | `cmd > all.log 2>&1`         |
| Log everything (shorthand)              | `cmd &> all.log`             |
| **Silence** everything                  | `cmd &> /dev/null`           |
| Output and errors in **separate** files | `cmd > out.txt 2> err.txt`   |

```bash
# Real result to a file, errors still visible on screen (Day 2 §4 idea):
./3_day.sh 5 2 > result.txt

# Your script sending its OWN usage message to stderr:
echo "Usage: $0 <name>" >&2

# Capture a command's full log — stdout AND stderr together:
./deploy.sh > deploy.log 2>&1

# Run a check silently, only care about pass/fail (Day 2 §5):
if command -v nginx &> /dev/null; then echo "installed"; fi
```

#### `>&2` vs `2>&1` — mirror images

Read `N>&M` as **"point stream N at stream M's destination."**

- `>&2` = `1>&2` = send **stdout → stderr**. Why `echo "error" >&2` lands on the
  error stream (used in your Day 3 script).
- `2>&1` = send **stderr → stdout**. **Merges** errors into normal output — for
  logging or piping both.

#### ⚠️ Order matters

`2>&1` copies wherever stdout points **at that moment**, so position changes
everything:

```bash
cmd > file 2>&1     # stdout→file, THEN stderr→(same file). BOTH in file ✅
cmd 2>&1 > file     # stderr→terminal (stdout still there), THEN stdout→file ❌
```

> ✅ Verified in real Bash: with `2>&1 > file`, the error line stays on the
> terminal and only normal output reaches the file — the opposite of what you
> probably wanted. Put the file redirect **first**.

#### Key takeaways
- `&` before a number = "it's a **stream**, not a filename."
- `>` overwrites, `>>` appends.
- `>&2` = my output → stderr; `2>&1` = errors → stdout.
- Merge both to a file: `> file 2>&1` (or `&> file`) — **redirect order matters**.

---

## Day 3

### Section 1 — Arithmetic with `$(( ))`

Bash does math inside **double parentheses**: `$(( expression ))`. This is called
**arithmetic expansion** — Bash evaluates the math and substitutes the result.

```bash
num1=10
num2=3

echo "sum=$((num1 + num2))"    # sum=13
echo "diff=$((num1 - num2))"   # diff=7
echo "prod=$((num1 * num2))"   # prod=30
echo "quot=$((num1 / num2))"   # quot=3   <- integer division!
```

#### The `$` is optional inside `(( ))`

Arithmetic context already knows `num1` is a variable, so both forms work:

```bash
echo $(( num1 + num2 ))     # preferred — cleaner
echo $(( $num1 + $num2 ))   # also works
```

#### Operators

| Operator | Meaning                        | Example          | Result |
|----------|--------------------------------|------------------|--------|
| `+`      | addition                       | `$((5 + 3))`     | `8`    |
| `-`      | subtraction                    | `$((5 - 3))`     | `2`    |
| `*`      | multiplication                 | `$((5 * 3))`     | `15`   |
| `/`      | **integer** division           | `$((10 / 3))`    | `3`    |
| `%`      | modulo (remainder)             | `$((10 % 3))`    | `1`    |
| `**`     | exponent (power)               | `$((2 ** 10))`   | `1024` |
| `++` `--`| increment / decrement          | `(( i++ ))`      | —      |
| `+=` `-=`| compound assignment            | `(( i += 5 ))`   | —      |

### Section 2 — The big gotcha: Bash only does integer math

**Bash cannot do decimals.** Division **truncates** (chops off the remainder) —
it does not round.

```bash
echo $((10 / 3))    # 3     (not 3.33)
echo $((9 / 10))    # 0     (not 0.9!)
echo $((7 / 2))     # 3     (not 3.5 — truncated, NOT rounded to 4)
```

#### Use `%` to get the remainder

```bash
echo $((10 / 3))    # 3  <- how many whole times
echo $((10 % 3))    # 1  <- what's left over
```

`%` is essential for things like converting seconds to `Xh Ym Zs` (Day 33).

#### Need real decimals? Use `bc` or `awk`

```bash
# bc: -l loads the math library, scale sets decimal places
echo "scale=2; 10 / 3" | bc        # 3.33

# awk: often easier, no pipe needed
awk 'BEGIN { printf "%.2f\n", 10 / 3 }'    # 3.33
```

### Section 3 — `$(( ))` vs `(( ))` — two different things

| Form        | Purpose                            | Use in                       |
|-------------|------------------------------------|------------------------------|
| `$(( ... ))`| **Returns a value** (expansion)    | `x=$((a + b))`, `echo $((a*b))` |
| `(( ... ))` | **Runs a command** (returns exit code) | `if (( a > b ))`, `(( i++ ))` |

```bash
result=$(( 5 + 3 ))        # $(( )) — gives you the value 8

if (( num1 > num2 )); then # (( ))  — used as a true/false test
    echo "num1 is bigger"
fi

(( counter++ ))            # (( ))  — performs an action, no value needed
```

> Remember from Day 2, Section 3: inside `(( ))` you can use normal math symbols
> (`>`, `<`, `==`) instead of the `-gt` / `-lt` / `-eq` flags that `[ ]` requires.

### Section 4 — Validating numeric input

This is where the Day 3 script needs hardening. Three problems to guard against:

#### Problem 1: missing arguments

```bash
$ ./3_day.sh
sum=0
3_day.sh: line 7: num1 / num2: division by 0
```
Empty variables become `0` in arithmetic — so you get garbage, then a crash.

#### Problem 2: division by zero

```bash
$ ./3_day.sh 10 0
3_day.sh: line 7: division by 0 (error token is "2")
```
Bash **cannot** divide by zero — it's a runtime error, not a warning.

#### Problem 3: non-numeric input is silently treated as 0 ⚠️

```bash
$ ./3_day.sh abc 5
sum=5        # "abc" silently became 0 — no error at all!
```
This is the **dangerous** one: no crash, no warning, just a **wrong answer**.

#### The fix — validate with a regex

```bash
#!/bin/bash

# 1. Check argument count
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <num1> <num2>" >&2
    exit 1
fi

num1="$1"
num2="$2"

# 2. Check both are integers (^-? allows negatives, [0-9]+ = one or more digits)
if ! [[ "$num1" =~ ^-?[0-9]+$ ]] || ! [[ "$num2" =~ ^-?[0-9]+$ ]]; then
    echo "Error: both arguments must be integers" >&2
    exit 1
fi

echo "sum=$((num1 + num2))"
echo "diff=$((num1 - num2))"
echo "prod=$((num1 * num2))"

# 3. Guard division by zero
if (( num2 == 0 )); then
    echo "quot=undefined (cannot divide by zero)" >&2
else
    echo "quot=$((num1 / num2))"
fi
```

That `^-?[0-9]+$` pattern is a **regex** — see Section 5 for a full breakdown.

#### Key takeaways
- Bash arithmetic is **integer only** — `/` truncates, never rounds.
- Empty or non-numeric variables silently become `0` — **always validate**.
- Division by zero is a **fatal error** — guard it before dividing.
- Send errors to stderr with `>&2` and `exit 1` (Day 2, Section 4).

### Section 5 — Regex matching with `=~` and `^-?[0-9]+$`

A **regex** (regular expression) is a pattern for describing what text should
look like. In Bash you test a string against one using the `=~` operator inside
double brackets:

```bash
if [[ "$num1" =~ ^-?[0-9]+$ ]]; then
    echo "It's a valid integer"
fi
```

> ⚠️ `=~` **only works inside `[[ ]]`** — never in single `[ ]`. This is one of
> the main reasons to prefer `[[ ]]` in Bash (Day 2, Section 2).

#### Breaking down `^-?[0-9]+$` piece by piece

Read it left to right as a sentence: *"from the start, an optional minus sign,
then one or more digits, then the end — and nothing else."*

| Part     | Name          | Meaning                                  |
|----------|---------------|------------------------------------------|
| `^`      | anchor        | **start** of the string                  |
| `-?`     | optional char | a minus sign, **zero or one** time       |
| `[0-9]`  | character set | **any single digit** from 0 to 9         |
| `+`      | quantifier    | the thing before it, **one or more** times |
| `$`      | anchor        | **end** of the string                    |

So `[0-9]+` together means "one or more digits" — `[0-9]` says *what*, and `+`
says *how many*.

#### Why the anchors `^` and `$` are critical

Without anchors, a regex matches if the pattern appears **anywhere** inside the
string. This is the classic beginner trap:

```bash
[[ "12abc" =~ [0-9]+ ]]        # TRUE!  ❌ matches the "12" part only
[[ "12abc" =~ ^-?[0-9]+$ ]]    # FALSE  ✅ correct — "abc" isn't allowed
```

`^` and `$` force the pattern to describe the **entire** string, not just a
fragment of it. **Almost always anchor your validation regexes.**

#### What it accepts and rejects

| Input   | Matches? | Why                                     |
|---------|----------|-----------------------------------------|
| `42`    | ✅       | digits only                             |
| `-42`   | ✅       | the optional `-` is used                |
| `0`     | ✅       | one digit is enough (`+` needs ≥ 1)     |
| `abc`   | ❌       | not digits                              |
| `12abc` | ❌       | anchors reject trailing text            |
| `3.14`  | ❌       | `.` isn't in `[0-9]` — **integers only**|
| `-`     | ❌       | `+` requires at least one digit         |
| `` (empty) | ❌    | `+` requires at least one digit         |
| `+5`    | ❌       | only `-` is allowed, not `+`            |

Note `3.14` failing is **intentional** — Bash arithmetic is integer-only
(Section 2), so rejecting decimals is correct here.

#### The quantifiers you'll use most

| Symbol | Meaning              | Example    | Matches            |
|--------|----------------------|------------|--------------------|
| `?`    | zero or **one**      | `-?`       | `""` or `-`        |
| `+`    | **one** or more      | `[0-9]+`   | `5`, `42`, `1000`  |
| `*`    | **zero** or more     | `[0-9]*`   | `""`, `5`, `42`    |
| `{n}`  | exactly **n** times  | `[0-9]{3}` | `123` (not `12`)   |
| `{n,m}`| between n and m      | `[0-9]{1,3}` | `1` to `999`     |

> Careful: `+` vs `*` matters. `^[0-9]*$` would accept an **empty string**
> (zero digits is "zero or more"), which is usually a bug in a validator.

#### Handy character sets

| Set        | Matches                          |
|------------|----------------------------------|
| `[0-9]`    | any digit                        |
| `[a-z]`    | any lowercase letter             |
| `[A-Za-z]` | any letter, either case          |
| `[a-zA-Z0-9_]` | letters, digits, underscore  |
| `[^0-9]`   | **NOT** a digit (`^` inside `[]` = negate) |
| `.`        | **any** single character         |

> Confusing but important: `^` means "start of string" *outside* brackets, but
> means "**not**" *inside* brackets. `[^0-9]` = "any non-digit".

#### Useful variations

```bash
# Positive integers only (no minus sign)
[[ "$n" =~ ^[0-9]+$ ]]

# Allow decimals: optional minus, digits, optional (dot + digits)
[[ "$n" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]     # \. is a literal dot

# Don't quote the regex! Quoting makes it a literal string, not a pattern
[[ "$n" =~ "^[0-9]+$" ]]    # ❌ WRONG — looks for that exact text
[[ "$n" =~ ^[0-9]+$ ]]      # ✅ RIGHT
```

That last one is a **big gotcha**: quoting the *variable* (`"$n"`) is required,
but quoting the *regex* breaks it — the quotes turn the pattern into literal
text to search for.

#### Capturing parts with `BASH_REMATCH`

When a regex matches, Bash stores the pieces in the `BASH_REMATCH` array — index
`0` is the whole match, and each `( )` group gets the next index:

```bash
date_str="2026-07-17"
if [[ "$date_str" =~ ^([0-9]{4})-([0-9]{2})-([0-9]{2})$ ]]; then
    echo "Full:  ${BASH_REMATCH[0]}"   # 2026-07-17
    echo "Year:  ${BASH_REMATCH[1]}"   # 2026
    echo "Month: ${BASH_REMATCH[2]}"   # 07
    echo "Day:   ${BASH_REMATCH[3]}"   # 17
fi
```

You'll need this for Day 32 (validating an IPv4 address).

#### Key takeaways
- `=~` works **only** inside `[[ ]]`.
- **Anchor with `^` and `$`** or you'll match fragments (`12abc` passing as a number).
- Quote the **variable**, never the **regex**.
- `?` = 0-or-1, `+` = 1-or-more, `*` = 0-or-more. Prefer `+` in validators.
- `^` outside brackets = "start"; `^` inside `[ ]` = "not".
- `( )` groups are captured into `${BASH_REMATCH[n]}`.

### Section 6 — The validation block, line by line

This is the full integer-check block from the Day 3 script. It pulls together
almost everything above, so let's read it **one line at a time**.

```bash
# Check both are integers
if ! [[ "$num1" =~ ^-?[0-9]+$ ]] || ! [[ "$num2" =~ ^-?[0-9]+$ ]]; then
    echo "Error: both arguments must be integers" >&2
    exit 1
fi
```

#### Line 1 — the condition

```bash
if ! [[ "$num1" =~ ^-?[0-9]+$ ]] || ! [[ "$num2" =~ ^-?[0-9]+$ ]]; then
```

Read it in seven small pieces:

| Piece                    | Meaning                                                    |
|--------------------------|------------------------------------------------------------|
| `if`                     | start a conditional — run the body only if it's true       |
| `[[ ... ]]`              | Bash's advanced test (supports regex — Day 2 §2)           |
| `"$num1"`                | the first argument, e.g. `25` (quoted so spaces are safe)  |
| `=~`                     | "matches the regular expression on the right"              |
| `^-?[0-9]+$`             | the regex: start, optional `-`, one+ digits, end (§5)      |
| `!`                      | **NOT** — flips the result                                 |
| <code>&#124;&#124;</code>| **OR** — true if either side is true                       |

Building it up:
- `[[ "$num1" =~ ^-?[0-9]+$ ]]` → true when `num1` **is** an integer.
- `! [[ ... ]]` → true when `num1` is **NOT** an integer.
- `A || B` → enter the `if` when `num1` is not an integer **OR** `num2` is not an
  integer.

**Plain English:** "If *either* argument is not a valid integer, run the error
handling below."

Truth-table for the `||`:

| num1 valid? | num2 valid? | `!A` | `!B` | `!A ‖ !B` | Enters `if`? |
|-------------|-------------|------|------|-----------|--------------|
| yes         | yes         | F    | F    | **F**     | no → do math |
| yes         | no          | F    | T    | **T**     | yes → error  |
| no          | yes         | T    | F    | **T**     | yes → error  |
| no          | no          | T    | T    | **T**     | yes → error  |

#### Line 2 — the error message

```bash
echo "Error: both arguments must be integers" >&2
```

`echo` prints the text; `>&2` sends it to **stderr** instead of stdout. (Full
explanation in Day 2 §4.) The short version:

| Stream | Number | Carries          |
|--------|--------|------------------|
| stdout | `1`    | normal results   |
| stderr | `2`    | errors, warnings |

`>&2` = "redirect this output to file descriptor **2** (stderr)." So error text
stays out of a file/pipe that's capturing the real results.

**Proof it works** — capture stdout to a file, errors to another:

```bash
$ ./3_day.sh 25 hello > out.txt 2> err.txt
$ cat out.txt        # (empty — no real result was produced)
$ cat err.txt
Error: both arguments must be integers
```

The error landed in `err.txt`, **not** `out.txt` — exactly because of `>&2`.

#### Line 3 — stop with a failure code

```bash
exit 1
```

Stops the script **immediately** and reports failure to the OS. By convention:

| Exit code    | Meaning              |
|--------------|----------------------|
| `0`          | success              |
| non-zero (`1`…) | failure / error   |

This is what lets another script do `if ./3_day.sh 25 10; then ...` — it reads
this exit code. (Ties back to Day 1: a subshell reports its result via the exit
code.)

#### Line 4 — close the block

```bash
fi
```

`fi` (`if` reversed) marks the end of the `if`. If the condition was false, Bash
skips straight past `fi` and continues to the arithmetic below.

#### Full flow with a real example

`./3_day.sh 25 hello`  (so `num1=25`, `num2=hello`):

1. `[[ "25" =~ ^-?[0-9]+$ ]]` → true → `! ` makes it **false**.
2. `[[ "hello" =~ ^-?[0-9]+$ ]]` → false → `! ` makes it **true**.
3. `false || true` → **true**, so enter the `if`.
4. Print `Error: both arguments must be integers` to **stderr**.
5. `exit 1` — script stops, failure code returned.

Contrast `./3_day.sh -15 42` (both valid):

1. `! [[ "-15" =~ ... ]]` → false (the `-?` allows the minus).
2. `! [[ "42"  =~ ... ]]` → false.
3. `false || false` → **false**, so **skip** the `if` and go do the math.

> ✅ All of the above is verified against real Bash: `25 10` and `-15 42` pass;
> `25 hello`, `10.5 3`, and `abc xyz` each print the error and exit `1`.

### Section 7 — Which bracket to use when (the complete guide)

Bash has **seven** bracket-ish constructs and they are NOT interchangeable. Here
is the whole map, then the details.

| Construct    | Name                    | Used for                          | Gives you        |
|--------------|-------------------------|-----------------------------------|------------------|
| `[ ... ]`    | test command (POSIX)    | conditions (old/portable)         | exit code        |
| `[[ ... ]]`  | test keyword (Bash)     | conditions (**preferred in Bash**)| exit code        |
| `(( ... ))`  | arithmetic evaluation   | math **as a test / action**       | exit code        |
| `$(( ... ))` | arithmetic expansion    | math **you want the value of**    | a **number**     |
| `$( ... )`   | command substitution    | capture a command's output        | **text** output  |
| `( ... )`    | subshell                | group commands in a child shell   | (runs commands)  |
| `{ ...; }`   | command grouping        | group commands in **current** shell| (runs commands) |
| `{ }`        | brace expansion         | generate lists / sequences        | expanded words   |
| `${ ... }`   | parameter expansion     | read/modify a variable's value    | a **value**      |

#### The two-question decision guide

1. **Am I testing a condition (true/false)?**
   - Comparing **numbers** → `(( ))` with `>`, `<`, `==`
   - Comparing **strings** or **files** → `[[ ]]` with `==`, `-z`, `-f`, `=~`
2. **Am I producing a value to use/store?**
   - A **number** from math → `$(( ))`
   - **Text** from a command → `$( )`
   - A **variable's** value → `${ }`

---

#### 1. `[ ... ]` — the old `test` command

Works everywhere (POSIX), but it's **fragile**. It's an ordinary command, so
unquoted variables word-split and break it:

```bash
x=""
[ $x == "a" ]      # ERROR: "unary operator expected" (becomes [ == a ])
y="a b"
[ $y == "a b" ]    # ERROR: "too many arguments"
```

⚠️ **Biggest trap:** inside `[ ]`, `>` and `<` are **redirection**, not comparison:

```bash
[ 5 > 3 ]          # does NOT compare! creates a file named "3" 😱
```

Use `[ ]` only for POSIX `sh` scripts. In Bash, reach for `[[ ]]`.

#### 2. `[[ ... ]]` — the Bash test keyword (**your default**)

Safer and more powerful. It's a keyword, not a command, so no word-splitting:

```bash
x=""
[[ $x == "a" ]]        # false — handles empty safely, even unquoted
y="a b"
[[ $y == "a b" ]]      # true  — spaces safe even unquoted
```

Supports things `[ ]` can't:

```bash
[[ "$name" == M* ]]              # wildcard/glob matching
[[ "$num" =~ ^[0-9]+$ ]]         # regex (Section 5)
[[ -f "$file" && -r "$file" ]]   # && and || work inside
```

⚠️ **Trap:** inside `[[ ]]`, `<` and `>` compare **strings** (ASCII order), NOT
numbers:

```bash
[[ 10 < 9 ]]       # TRUE — because "1" comes before "9" as text! ❌
[[ 10 -lt 9 ]]     # false — correct, -lt forces numeric compare ✅
```

So for **numbers inside `[[ ]]`**, use `-lt -gt -eq -ne -le -ge` (Day 2 §3),
**not** `<` `>`.

#### 3. `(( ... ))` — arithmetic evaluation (math as a test/action)

Best way to compare **numbers**, because you get natural math symbols:

```bash
if (( num1 > num2 )); then echo "bigger"; fi   # clean numeric compare
(( count++ ))                                    # perform an action
(( total += 5 ))
```

⚠️ **Trap:** `(( ))` returns its result as an exit code, and **`0` is "false"**:

```bash
(( 1 ))    # exit 0 → true
(( 0 ))    # exit 1 → FALSE!
```

This bites with `set -e`: a line like `(( count = 0 ))` "fails" (exit 1) and can
kill a strict-mode script. Guard it: `(( count = 0 )) || true`.

#### 4. `$(( ... ))` — arithmetic expansion (math you want the value of)

Same math, but it **hands back the number** so you can store or print it:

```bash
sum=$(( num1 + num2 ))         # store the value
echo "Total: $(( a * b ))"     # print the value
```

> `(( ))` vs `$(( ))`: the `$` means "**give me the value**." No `$` means
> "**use it as a true/false test or an action**." (Day 3 §3.)

#### 5. `$( ... )` — command substitution (capture output as text)

Runs a command and substitutes its **text output**:

```bash
today=$(date +%F)              # today="2026-07-18"
files=$(ls | wc -l)            # capture a count
user=$(whoami)                 # Day 1 used this!
```

Prefer `$( )` over old backticks `` `...` `` — it nests cleanly:
`outer=$(echo $(date))`.

#### 6. `( ... )` vs `{ ...; }` — grouping commands

Both group commands, but the difference is **which shell they run in** — this is
a favorite interview question:

```bash
cd /start

( cd /tmp; pwd )      # subshell: prints /tmp
pwd                   # still /start — the cd was thrown away!

{ cd /tmp; pwd; }     # current shell: prints /tmp
pwd                   # now /tmp — the cd STUCK
```

- `( )` = **subshell** (child). Changes (`cd`, variables) vanish when it ends.
  Great for "do this without disturbing my current shell." (Day 1 subshell idea.)
- `{ }` = **same shell**. Changes persist. Note the required **spaces inside** and
  the **`;` before `}`**.

#### 7. `{ }` — brace expansion (generate lists) & `${ }` — variables

Confusingly, bare `{ }` with **no `$`** generates lists *before* the command runs:

```bash
echo {1..5}            # 1 2 3 4 5
echo {a,c,e}           # a c e
touch file{1,2,3}.txt  # makes file1.txt file2.txt file3.txt
cp app.conf{,.bak}     # cp app.conf app.conf.bak  (handy trick!)
```

And `${ }` (**with** `$`) is parameter expansion — reading/reshaping a variable:

```bash
name="report.txt"
echo "${name}"          # report.txt
echo "${name%.txt}"     # report   (strip suffix — Day 27)
echo "${#name}"         # 10       (length)
echo "${name:-default}" # use "default" if name is empty
```

#### Cheat-sheet: the mistakes to never make

| You wrote                | Problem                              | Use instead            |
|--------------------------|--------------------------------------|------------------------|
| `[ 5 > 3 ]`              | `>` redirects, makes a file `3`      | `(( 5 > 3 ))`          |
| `[[ 10 < 9 ]]` for nums  | string compare (`10` < `9`)          | `(( 10 < 9 ))` or `-lt`|
| `[ $x == a ]` (empty x)  | word-split → syntax error            | `[[ $x == a ]]`        |
| `if $(( a > b ))`        | `$(( ))` returns a value, not a test | `if (( a > b ))`       |
| `` x=`cmd` ``            | backticks don't nest well            | `x=$(cmd)`             |
| `( cd dir )` expecting cd to stick | subshell throws it away    | `{ cd dir; }` or plain `cd` |

#### Golden rules
- **Numbers** → `(( ))` (test) or `$(( ))` (value).
- **Strings / files** → `[[ ]]`.
- **Capture output** → `$( )`.
- **Variable's value** → `${ }`.
- Avoid `[ ]` in Bash; avoid `<`/`>` for numeric compares.

### Section 8 — Counters & incrementing (Python `+= 1` in Bash)

A **counter** is just a number you bump up as you loop. In Python you'd write
`counter = 1` then `counter += 1`; Bash is the same idea with slightly different
syntax (the `++`/`+=` operators from §1).

| Python              | Bash                     | Notes                          |
|---------------------|--------------------------|--------------------------------|
| `counter = 1`       | `counter=1`              | **no spaces** around `=`, no `$` |
| `counter += 1`      | `(( counter += 1 ))`     | closest match                  |
| `counter += 1`      | `(( counter++ ))`        | shorthand for +1               |
| `counter = counter + 1` | `counter=$(( counter + 1 ))` | explicit form            |

Remember: **assign** with no `$` (`counter=1`), **read** with `$`
(`echo "$counter"`), and do the **math** inside `(( ))` or `$(( ))` — a bare
`counter = counter + 1` doesn't do arithmetic (§3).

#### The counter-in-a-loop pattern (used in Day 10)

```bash
counter=1
for arg in "$@"; do
    echo "$counter: $arg"
    (( counter++ ))
done
# ./script.sh foo bar baz  ->  1: foo / 2: bar / 3: baz
```

#### ⚠️ The `(( i++ ))` + `set -e` gotcha

`(( i++ ))` returns an **exit code based on the value *before* the increment**.
So when `i` is `0`, `(( i++ ))` "returns" the old value `0` → treated as
**false** → exit code `1`. On its own that's harmless, but under strict mode
(`set -e`, Day 0 §10) that non-zero exit can **abort the script**:

```bash
i=0
(( i++ ))          # i becomes 1, but the command exits 1 → set -e would quit here
```

Safe forms that always return success:

```bash
(( i += 1 ))       # compound assignment — returns 0
i=$(( i + 1 ))     # explicit — returns 0
(( ++i ))          # PRE-increment — returns the NEW value (1 = success)
```

> Rule of thumb: quick scripts, `(( i++ ))` is fine (and everyone uses it). In
> strict-mode production scripts, prefer `(( i += 1 ))` or `i=$(( i + 1 ))`. If
> your counter starts at `1` (like Day 10), `(( i++ ))` is safe anyway.

---

## Day 4

### Section 1 — Reading user input with `read`

Until now your scripts got their input from **arguments** (`$1`, `$2` — Day 2).
`read` is the other way: it **pauses the script and waits for the user to type**
something, then stores it in a variable.

```bash
read -p "Enter a directory path: " path
```

Piece by piece:

| Piece                          | Meaning                                             |
|--------------------------------|-----------------------------------------------------|
| `read`                         | the command — read one line from input (stdin)      |
| `-p "Enter a directory path: "`| **p**rint this prompt first (no newline after it)   |
| `path`                         | the **variable** the typed text gets stored in      |

After that line runs, whatever the user typed is in `$path`, and you use it like
any variable — quoted: `"$path"`.

```bash
read -p "Enter a directory path: " path
echo "You typed: $path"
```

#### If you don't name a variable, it goes into `$REPLY`

```bash
read -p "Continue? "        # no variable named
echo "You said: $REPLY"     # bash stores it in REPLY by default
```

#### Reading several values at once

`read` splits the typed line on spaces into the variables you list:

```bash
read -p "First and last name: " first last
echo "Hi $first, surname $last"     # input "Ada Lovelace" -> first=Ada last=Lovelace
```

(The last variable soaks up **all** the remaining words.)

#### Useful `read` flags

| Flag  | What it does                                   | Example                        |
|-------|------------------------------------------------|--------------------------------|
| `-p`  | show a **prompt** first                        | `read -p "Name: " n`           |
| `-r`  | **raw** — don't let `\` act as an escape (use this by default) | `read -r line`   |
| `-s`  | **silent** — don't echo typing (passwords)     | `read -s -p "Password: " pw`   |
| `-t`  | **timeout** in seconds                         | `read -t 5 -p "Quick! " x`     |
| `-n`  | stop after **N characters** (no Enter needed)  | `read -n 1 -p "Y/N? " ans`     |
| `-a`  | read words into an **array**                   | `read -a words`                |

#### Two habits worth building now

**1. Prefer `read -r`.** Without `-r`, Bash treats a backslash as an escape
character and mangles input. Verified:

```bash
read x    <<< 'a\tb'   # x = a\tb typed...  -> becomes "atb"  (backslash eaten) ❌
read -r y <<< 'a\tb'   # -> stays "a\tb"  (literal) ✅
```

**2. `IFS= read -r line` when you want the whole line exactly.** Plain `read`
strips leading/trailing spaces; `IFS=` keeps them:

```bash
read z        <<< "   spaced   "   # -> "spaced"        (trimmed)
IFS= read -r w <<< "   spaced   "   # -> "   spaced   "  (preserved)
```

This `while IFS= read -r line` pattern is the correct way to read a file line by
line — you'll use it in Day 21 and it's a classic interview point (Day 52).

### Section 2 — Putting it together: the Day 4 script

Your Day 4 task: prompt for a directory path, then report whether it **exists**,
and if so whether it's **readable** and **writable**. This combines `read`
(Section 1) with the file-test operators (Day 2 §3: `-d`, `-r`, `-w`).

```bash
#!/bin/bash
read -p "Enter a directory path: " path

if [[ -d "$path" ]]; then
    echo "directory exists"
    if [[ -r "$path" ]]; then
        echo "directory is readable"
    fi
    if [[ -w "$path" ]]; then
        echo "directory is writable"
    fi
else
    echo "directory does not exist"
fi
```

How it flows:

1. `read` pauses and stores what you type in `$path`.
2. `[[ -d "$path" ]]` → is it an existing directory? (Day 2 §3)
3. If yes, the **nested** `if`s check readable (`-r`) and writable (`-w`)
   independently — a directory can be one, both, or neither.
4. If it's not a directory, the `else` reports that.

> Why quote `"$path"`? A user might type a path with spaces like
> `/Users/mahima/My Folder`. Unquoted, `-d $path` would break into two words and
> fail (Day 0 §6, Day 3 §7). Quoting keeps it as one path.

#### Key takeaways
- `read` waits for typed input; `read -p "prompt" var` is the common form.
- No variable named → the input lands in `$REPLY`.
- Default to `read -r`; use `IFS= read -r line` to read a whole line verbatim.
- Combine `read` with `-d`/`-r`/`-w` tests to validate what the user typed.

---

## Day 6

### Section 1 — The `date` command basics

`date` prints the current date and time. On its own it gives a long default:

```bash
$ date
Sun Jul 19 02:03:09 IST 2026
```

The power comes from **`+FORMAT`** — a `+` followed by `%`-codes that pick
*exactly* which pieces you want and how to arrange them:

```bash
$ date +%F
2026-07-19
$ date +%s
1784406789
```

- Anything after `+` is a **format string**. `%`-codes get replaced with values;
  everything else (dashes, spaces, colons) is printed literally.
- Wrap it in quotes when your format has spaces: `date +"%F %T"`.

### Section 2 — Format specifiers (the `%` codes)

The ones you'll actually use:

| Code | Means                        | Example output |
|------|------------------------------|----------------|
| `%F` | full date = `%Y-%m-%d`       | `2026-07-19`   |
| `%s` | Unix timestamp (secs since 1970) | `1784406789` |
| `%Y` | 4-digit year                 | `2026`         |
| `%m` | month (01–12)                | `07`           |
| `%d` | day of month (01–31)         | `19`           |
| `%H` | hour (00–23)                 | `02`           |
| `%M` | minute (00–59)               | `03`           |
| `%S` | second (00–59)               | `09`           |
| `%T` | full time = `%H:%M:%S`       | `02:03:09`     |
| `%A` | weekday name                 | `Sunday`       |
| `%B` | month name                   | `July`         |
| `%Z` | timezone name                | `IST`          |
| `%j` | day of year (001–366)        | `200`          |

Mix them freely with literal text:

```bash
$ date +"%Y-%m-%d"                 # 2026-07-19   (same as %F)
$ date +"%F %T"                    # 2026-07-19 02:03:09
$ date +"%A, %B %d, %Y"            # Sunday, July 19, 2026
$ date -u +"%F %T %Z"              # 2026-07-18 20:33:09 UTC   (-u = UTC)
```

> `-u` prints **UTC** instead of your local timezone — important on servers,
> which usually run in UTC.

### Section 3 — Command substitution: capturing the output

This is the **real concept** of Day 6. `date` just *prints* — to actually *use*
its value (store it, put it in a filename, build a message), wrap it in
**`$( ... )`**, which runs the command and substitutes its output right there
(Day 3 §7):

```bash
today=$(date +%F)                  # store it in a variable
echo "Today is $today"             # Today is 2026-07-19

echo "Backup made at $(date +%T)"  # drop it straight into a string
logfile="app-$(date +%F).log"      # app-2026-07-19.log
```

Without `$( )` you can only *see* the date; with `$( )` you can *use* it.

### Section 4 — The Day 6 solution

Task: print the current date as `YYYY-MM-DD` **and** the Unix timestamp.

```bash
#!/bin/bash
echo "Date: $(date +%F)"          # Date: 2026-07-19
echo "Timestamp: $(date +%s)"     # Timestamp: 1784406789
```

- `date +%F` → the date in `YYYY-MM-DD`.
- `date +%s` → seconds since Jan 1, 1970 (the Unix timestamp).
- `$( )` → command substitution drops each result into the echoed string.

> ⚠️ The `awk 'BEGIN {srand(); print srand()}'` trick you first tried *does*
> return the timestamp (srand with no arg seeds from the clock and returns the
> previous seed), but it's an obscure hack, and it can't give you the `%F` date.
> `date +%s` is the clear, correct tool.

### Section 5 — Where you'll actually use `date` (DevOps)

`date` shows up constantly in real scripts:

```bash
# Timestamped backup file (Day 36)
tar -czf "backup-$(date +%F).tar.gz" /etc

# Timestamped log line — a logging function (Day 20) leans on this
echo "[$(date +'%F %T')] deploy started"

# A unique, sortable filename
report="report-$(date +%Y%m%d-%H%M%S).csv"   # report-20260719-020309.csv
```

`%F`-style names sort chronologically when listed, which is why timestamped
filenames use `YYYY-MM-DD` order.

### Section 6 — Date math, and the macOS vs Linux gotcha ⚠️

Doing arithmetic ("yesterday", "2 days ago") is where **macOS and Linux differ**
— a very common cross-platform trap. Your Mac uses **BSD `date`**; Linux servers
use **GNU `date`**, and the flags are *not* the same:

| Goal                     | macOS (BSD) — your machine     | Linux (GNU) — servers          |
|--------------------------|--------------------------------|--------------------------------|
| Yesterday's date         | `date -v-1d +%F`               | `date -d "yesterday" +%F`      |
| Tomorrow                 | `date -v+1d +%F`               | `date -d "tomorrow" +%F`       |
| 2 days ago               | `date -v-2d +%F`               | `date -d "2 days ago" +%F`     |
| 1 hour ago               | `date -v-1H +%T`               | `date -d "1 hour ago" +%T`     |
| Epoch → human date       | `date -r 1784406222`           | `date -d @1784406222`          |

Verified on your Mac:
```bash
$ date -v-1d +%F        # 2026-07-18   (yesterday)
$ date -v+1d +%F        # 2026-07-20   (tomorrow)
$ date -r 1784406222 +"%F %T"   # 2026-07-19 01:53:42
```

> Since you're learning for **Linux DevOps** but developing on **macOS**, write
> scripts targeting GNU `date` (`-d`), but know they'll need the `-v` form to
> test locally. Installing GNU coreutils (`brew install coreutils`) gives you
> `gdate`, which behaves like Linux's `date`. This exact issue comes up in Day 30
> (last-24-hours log filter) and Day 36 (backups).

#### Key takeaways
- `date +FORMAT` picks exactly the fields you want; `%F` = date, `%s` = timestamp.
- **Capture** it with `$(date ...)` — that's the Day 6 concept, command substitution.
- `-u` = UTC (servers), quote formats containing spaces.
- Date **math** differs: macOS `date -v-1d`, Linux `date -d "yesterday"`.

---

## Day 7

### Section 1 — The two kinds of links: symbolic & hard

Linux has **two** ways to make one file reachable under another name. They look
similar but work very differently. (The file-test operators used here — `-e`,
`-f`, `-d`, `-L`, `-s` — live in Day 2 §3.)

#### 1. Symbolic links (symlinks / "soft links")

A **symlink** is a tiny file whose only content is **a path** pointing to another
file or directory — the Linux version of a **shortcut** (Windows) or **alias**
(macOS). Open the link and the system transparently redirects you to the
**target**.

```
softlink  ──points to──►  /real/path/to/file.txt
```

Create it with **`ln -s TARGET LINKNAME`** (`-s` = symbolic). `ls -l` shows a
leading `l` and the arrow:

```bash
$ ln -s realfile.txt softlink.txt
$ ls -l softlink.txt
lrwxr-xr-x  1 you staff  12 Jul 19 softlink.txt -> realfile.txt
^                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
l = it's a link                    points here
```

Properties:
- Stores a **path**, not the data — so most tools and tests **follow** it to the
  target (`-f`, `-d`, `-e`), *except* **`-L`** (also `-h`), which checks the link
  **itself**. This "follow vs. don't-follow" split is what causes the Day 7
  ordering bug (§3).
- Can point **across filesystems/disks**, and can link **directories**.
- **Breaks** if the target is moved or deleted — a "dangling" link (see §2).

#### 2. Hard links

A **hard link** isn't a pointer at all — it's a **second name for the exact same
data**. Every file's real bytes live in an *inode*; a hard link is another
directory entry pointing at that **same inode**, so both names are equal owners
of the data.

Create it with **`ln TARGET LINKNAME`** (no `-s`). `ls -li` shows both names
sharing **one inode number** (first column) and a link count of 2 — verified:

```bash
$ ln original.txt hardlink.txt
$ ls -li
48081761 -rw-r--r--  2 you staff  17 original.txt   # same inode ↓, link count 2
48081761 -rw-r--r--  2 you staff  17 hardlink.txt
```

Properties:
- Shares the **same inode/data** — a change through one name shows in the other.
- **Survives deletion** of the original name: after `rm original.txt`,
  `hardlink.txt` still holds the content (the data lives until *every* name is
  gone). Verified.
- Must be on the **same filesystem**, and normally **can't** link a directory.

#### Symlink vs hard link at a glance

| Aspect              | Symbolic (soft) link          | Hard link                 |
|---------------------|-------------------------------|---------------------------|
| Stores              | a **path** to the target      | the **same inode** (data) |
| Create              | `ln -s target link`           | `ln target link`          |
| `ls -l` shows       | `link -> target`, leading `l` | a normal-looking file     |
| Cross-filesystem?   | **yes**                       | no                        |
| Link a directory?   | **yes**                       | no (normally)             |
| Target deleted →    | link **breaks** (dangling)    | data **survives**         |

Symlinks are everywhere in DevOps; hard links mostly show up in backup snapshots
and de-duplication.

### Section 2 — Why symlinks are used

Symlinks give you a **stable name that can point at a changing thing**:

- **Zero-downtime deploys (the classic):** `/app/current -> /app/releases/2026-07-19`.
  Deploy into a new dated folder, then just **repoint the link** — instant switch,
  and rollback = point it back. (How Capistrano-style deploys work.)
- **Shared libraries:** `libssl.so -> libssl.so.1.1` — programs use the stable
  name while the real versioned file changes on upgrade.
- **Enable/disable configs:** nginx's `sites-enabled/site -> sites-available/site`
  — link it to enable, delete the link to disable; the real config stays put.
- **Dotfiles in git:** `~/.bashrc -> ~/dotfiles/bashrc` — configs live in a repo
  but still sit where the system expects them.

#### The dangling-link gotcha

A symlink only stores a *path*, so if the target moves or is deleted the link
still exists but points at nothing:

```bash
$ ls -l broken_link
lrwxr-xr-x  broken_link -> /nope/gone.txt   # link is fine...
$ cat broken_link
cat: broken_link: No such file or directory  # ...target is gone
```

For a broken link: `-L` is **true** (still a symlink) but `-e` is **false**
(target missing) — a handy pair to detect them.

> Contrast: a **hard link** (`ln` with **no** `-s`) is a second *name* for the
> same underlying data, not a path pointer, so it doesn't break if the original
> name is removed. Symlinks are far more common.

### Section 3 — The Day 7 solution + the ordering bug

Here's the version you wrote:

```bash
if [[ -f "$path" ]]; then
    echo "it's regular file"
elif [[ -d "$path" ]]; then
    echo "it's directory"
elif [[ -L "$path" ]]; then       # ⚠️ too late!
    echo "it's a symlink"
else
    echo "file doesn't exist"
fi
```

**The bug:** because `-f` follows a symlink to its target, a symlink pointing at
a real file matches `-f` **first** and is reported as `"regular file"`. Your
`-L` branch only ever runs for **broken** symlinks. Verified:

| Path                    | Your order (`-f` first) | Correct (`-L` first) |
|-------------------------|-------------------------|----------------------|
| a regular file          | regular file ✅         | regular file ✅      |
| a directory             | directory ✅            | directory ✅         |
| **symlink → real file** | **regular file ❌**     | **symlink ✅**       |
| broken symlink          | symlink ✅              | symlink ✅           |

**The fix — check `-L` first**, since it's the only test that doesn't follow the
link:

```bash
#!/bin/bash
path=$1

if [[ -L "$path" ]]; then          # check the LINK before following it
    echo "it's a symlink"
elif [[ -f "$path" ]]; then
    echo "it's a regular file"
elif [[ -d "$path" ]]; then
    echo "it's a directory"
elif [[ -e "$path" ]]; then        # exists but some other type (socket, etc.)
    echo "it exists (special file)"
else
    echo "file doesn't exist"
fi
```

Order matters whenever tests can overlap: put the **most specific / non-following**
check (`-L`) first, general ones (`-e`) last. (File tests: Day 2 §3; permissions
behind them: Day 0 §4.)

#### Key takeaways
- `-f`/`-d`/`-e` **follow** symlinks; `-L` inspects the **link itself**.
- Therefore check **`-L` first**, or symlinks-to-files get mislabeled.
- Broken symlink = `-L` true **and** `-e` false.
- `ln -s TARGET LINK` makes one; `ls -l` shows `link -> target` with a leading `l`.

---

## Day 9

### Section 1 — The `id` command & command-exit-status conditionals

`id` looks a user up in the system's **account database** and prints their
numeric IDs and group memberships:

```bash
$ id
uid=501(admin) gid=20(staff) groups=20(staff),80(admin),...
$ id root
uid=0(root) gid=0(wheel) groups=0(wheel),...
```

Handy variants (pull out just one piece):

| Command   | Prints                        | Example  |
|-----------|-------------------------------|----------|
| `id`      | everything for the current user | `uid=501(admin)...` |
| `id NAME` | everything for that user      | `id root`   |
| `id -u`   | just the **UID** (number)     | `501`    |
| `id -un`  | just the **username**         | `admin`  |
| `id -g`   | primary **group ID**          | `20`     |
| `id -gn`  | primary **group name**        | `staff`  |
| `id -Gn`  | **all** group names           | `staff everyone ...` |

#### Why `id` is used to check if a user exists

The **whole trick** of Day 9 is `id`'s **exit code**:

- User **exists** → `id` prints their info and exits **`0`** (success).
- User **missing** → `id` prints `no such user` to stderr and exits **non-zero**.

So you drop the command straight into an `if` — no `[[ ]]` needed — and silence
its output (Day 2 §5) because you only care about success/failure, not the text:

```bash
if id "$user" &>/dev/null; then
    echo "user exists"
else
    echo "user does not exist"
fi
```

This is the Day 9 concept: **a command's exit status IS the condition.** `0` =
true/success, non-zero = false/failure. (Contrast: `[[ ]]` is itself just a
command that exits 0/1.)

> Why `id` and not `grep /etc/passwd`? `id` consults **all** account sources (the
> local file *and* network directories like LDAP/Active Directory), so it finds
> users that aren't in the local file. On Linux, `getent passwd "$user"` is
> another exit-code-friendly way that also queries those network sources.

### Section 2 — Where Linux users live: `/etc/passwd`

Every account on a Linux system has a line in **`/etc/passwd`**. It's a plain
text file, **readable by everyone** (many programs need to map UID numbers to
names). Each line has **7 colon-separated fields**:

```
mahima:x:1000:1000:Mahima K:/home/mahima:/bin/bash
   │   │   │    │      │          │           │
   │   │   │    │      │          │           └─ 7. login shell
   │   │   │    │      │          └───────────── 6. home directory
   │   │   │    │      └──────────────────────── 5. GECOS (full name/comment)
   │   │   │    └─────────────────────────────── 4. primary group ID (GID)
   │   │   └──────────────────────────────────── 3. user ID (UID)
   │   └──────────────────────────────────────── 2. password placeholder
   └──────────────────────────────────────────── 1. username
```

| # | Field    | Meaning                                                      |
|---|----------|--------------------------------------------------------------|
| 1 | username | login name                                                   |
| 2 | password | just **`x`** = "the real hash lives in `/etc/shadow`" (§3)    |
| 3 | UID      | numeric user ID — **`0` = root**, 1–999 = system, 1000+ = people |
| 4 | GID      | numeric primary group ID                                     |
| 5 | GECOS    | comment: full name, phone, etc.                              |
| 6 | home     | home directory (`/home/mahima`)                              |
| 7 | shell    | login shell; **`/usr/sbin/nologin`** or `/bin/false` = can't log in |

- **UID 0 is root** — that's what actually defines the superuser, not the name.
- Service accounts (nginx, postgres) use `nologin` as the shell so nobody can log
  in as them — a security practice.

```bash
grep "^mahima:" /etc/passwd     # look up one user's line
cut -d: -f1 /etc/passwd         # list all usernames (field 1, ":" separator)
```

> ⚠️ **macOS difference (your machine):** `/etc/passwd` exists but is only used in
> single-user mode — it lists a handful of system accounts (`root`, `nobody`).
> Real users live in **Open Directory**; list them with `dscl . -list /Users`.
> `id` still works normally. On Linux servers, `/etc/passwd` is the real thing.

### Section 3 — Where passwords live: `/etc/shadow`

Notice field 2 of `/etc/passwd` is just `x`, not the actual password. The real
**hashed passwords** live in **`/etc/shadow`** — and this is a deliberate
security split:

- `/etc/passwd` **must be world-readable** (programs map UIDs↔names constantly).
- If password hashes sat in that readable file, **any user could copy them and
  crack them offline**. So the hashes were moved to `/etc/shadow`, which is
  **readable only by root** (`-rw-r----- root shadow`).

`/etc/shadow` has **9 colon-separated fields** (most are password-aging policy):

```
mahima:$6$Xy9z$abc123...:19700:0:99999:7:::
```

| # | Field           | Meaning                                              |
|---|-----------------|------------------------------------------------------|
| 1 | username        | matches `/etc/passwd`                                 |
| 2 | **hashed password** | the algorithm + salt + hash (see below)          |
| 3 | last change     | days since 1970 the password was last changed        |
| 4 | min age         | min days before it *can* be changed again            |
| 5 | max age         | max days before it *must* be changed (aging)         |
| 6 | warn            | days of warning before expiry                        |
| 7 | inactive        | grace days after expiry before the account locks     |
| 8 | expire          | date (days since 1970) the account fully expires     |
| 9 | reserved        | unused                                               |

The **hash field** (field 2) encodes the algorithm as `$id$salt$hash`:

| Value        | Meaning                                     |
|--------------|---------------------------------------------|
| `$6$...`     | SHA-512 hash (common modern default)        |
| `$y$...`     | yescrypt (newer default on some distros)    |
| `*` or `!`   | **login disabled / no valid password**      |
| `!` prefix   | account **locked** (e.g. `!$6$...`)         |
| (empty)      | **no password** — dangerous                 |

- Passwords are **hashed, not encrypted** — the system never stores the real
  password, only a one-way hash it re-computes at login to compare.
- You never edit `/etc/shadow` by hand — use `passwd`, `chage`, `usermod`.

> ⚠️ **macOS difference:** there is **no `/etc/shadow`** on macOS — password data
> is kept in **Open Directory** (`/var/db/dslocal/...`), managed via `dscl` /
> `passwd`. `/etc/shadow` is a **Linux** concept, which is what matters for DevOps.

### Section 4 — The Day 9 solution

```bash
#!/bin/bash
user=$1

# 1. Require exactly one argument
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <username>" >&2
    exit 1
fi

# 2. Sanity-check the username format (defensive; id would also reject junk)
if ! [[ $user =~ ^[a-zA-Z_][a-zA-Z0-9_-]*$ ]]; then
    echo "Error: '$user' is not a valid username" >&2
    exit 1
fi

# 3. The real check — id's EXIT CODE tells us if the user exists
if id "$user" &>/dev/null; then
    echo "user exists"
else
    echo "user does not exist"
fi
```

- The `id ... &>/dev/null` line is the heart of it — command exit status as the
  condition (§1), output silenced with `&>/dev/null` (Day 2 §5).
- Errors go to **stderr** (`>&2`) with `exit 1` (Day 2 §4).
- Username regex `^[a-zA-Z_][a-zA-Z0-9_-]*$`: start with a letter/underscore, then
  letters/digits/`_`/`-` — real usernames don't start with a digit or `-`.

#### Key takeaways
- `id NAME` → exit `0` if the user exists, non-zero if not; use it **as** the `if`
  condition, silenced with `&>/dev/null`.
- `/etc/passwd` = the user list (7 fields, world-readable); **UID 0 = root**;
  field 2 is just `x`.
- `/etc/shadow` = the password **hashes** (root-only), split off from passwd for
  security; hashes are one-way, formatted `$id$salt$hash`.
- macOS uses **Open Directory** instead of these files — `id` works, but the files
  differ; Linux is the DevOps target.

---

## Day 11

### Section 1 — The `case` statement: syntax & anatomy

`case` matches **one value against several patterns** — a cleaner alternative to a
long `if/elif/elif/else` when you're checking the *same* variable against many
fixed options.

```bash
case "$variable" in
    pattern1)
        commands
        ;;
    pattern2|pattern3)      # | means OR
        commands
        ;;
    *)                      # catch-all (like else)
        commands
        ;;
esac
```

| Piece            | Meaning                                                      |
|------------------|-------------------------------------------------------------|
| `case "$x" in`   | start; match `$x` against the patterns below                |
| `pattern)`       | a branch — ends with a single `)`                           |
| `;;`             | **ends each branch** (double semicolon — easy to forget!)   |
| `a\|b)`          | `\|` = **OR**: match `a` *or* `b`                           |
| `*)`             | **catch-all** default, matches anything (put it **last**)   |
| `esac`           | closes the block (`case` spelled backwards, like `if`/`fi`) |

> Always quote the subject: `case "$1" in`. And the `*)` branch should come
> **last**, because `case` uses the **first** pattern that matches.

### Section 2 — Pattern matching power

`case` patterns aren't plain strings — they're **globs** (the same wildcards as
filenames, Day 0 §2), which makes `case` far more powerful than it first looks:

| Pattern       | Matches                                    |
|---------------|--------------------------------------------|
| `start`       | exactly `start`                            |
| `a\|b\|c`     | `a`, `b`, or `c`                           |
| `*.txt`       | anything ending in `.txt`                  |
| `*.jpg\|*.png`| any image (combine glob + OR)              |
| `[Yy]`        | `Y` or `y` (a character set)               |
| `[Yy][Ee][Ss]`| `yes` in any capitalization                |
| `?`           | exactly one character                      |
| `*`           | anything (the catch-all)                   |

Verified examples:

```bash
case "$file" in
    *.txt)        echo "text file" ;;
    *.jpg|*.png)  echo "image" ;;
    *)            echo "other" ;;
esac

# case-insensitive yes/no
case "$answer" in
    [Yy]|[Yy][Ee][Ss]) echo "YES" ;;
    [Nn]|[Nn][Oo])     echo "NO"  ;;
    *)                 echo "unclear" ;;
esac
```

### Section 3 — The Day 11 solution (init-script pattern)

Task: accept `start|stop|restart|status` and print what it would do; anything
else prints usage.

```bash
#!/bin/bash

case "$1" in
    start)
        echo "Starting the service..."
        ;;
    stop)
        echo "Stopping the service..."
        ;;
    restart)
        echo "Restarting the service..."
        ;;
    status)
        echo "Showing service status..."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}" >&2
        exit 1
        ;;
esac
```

Two things worth noticing:

1. **No-argument is handled for free.** With no argument, `$1` is empty, which
   matches none of the four patterns → falls to `*)` → usage + `exit 1`. No
   separate `$#` check needed. (Verified: no arg → usage, exit 1.)
2. **Errors → stderr + `exit 1`** in the `*)` branch — the habits from Days 8–9.

> Real-world tie-in: this is the exact shape of `/etc/init.d/` service scripts,
> and what `systemctl start|stop|restart|status nginx` maps to underneath. The
> hint "mirrors init-script structure" is literal.

### Section 4 — `case` vs `if/elif`, and fall-through

**Why `case` over `if/elif` here?** You *could* write
`if [[ "$1" == "start" ]]; then ... elif [[ "$1" == "stop" ]] ...`, but `case` is
less repetitive, reads top-to-bottom like a table, and supports glob patterns.
Reach for `case` when matching **one** variable against **many fixed values**;
reach for `if` when conditions are **different questions** (`-f`, `-gt`, `&&`).

**Branch terminators** — `;;` is what you'll use 99% of the time, but there are
two fall-through variants:

| Ender | Behavior                                              | Bash version |
|-------|------------------------------------------------------|--------------|
| `;;`  | end the branch, **skip** the rest (normal)           | all          |
| `;&`  | **fall through** and run the next branch unconditionally | **bash 4+** |
| `;;&` | continue **testing** the remaining patterns          | **bash 4+**  |

> ⚠️ `;&` and `;;&` **do not work on your Mac's bash 3.2** — they throw a syntax
> error (verified). They're fine on Linux servers (bash 4/5). Stick to `;;` for
> portable scripts; you'll rarely need the others.

#### Key takeaways
- `case "$x" in … esac`; each branch ends with **`;;`**; `*)` is the catch-all,
  placed **last**.
- Patterns are **globs** — `*.txt`, `[Yy]`, `a|b` — not just literal strings.
- First matching pattern wins, so order from **specific → general**.
- `case` shines for one-variable-many-values (menus, subcommands, init scripts).

---

# Tier 2 — Loops, Functions & Text Processing (Days 16–35): Pre-flight Primer

> Read this **before** starting Day 16. Tier 1 was about single decisions
> (`if`, `case`, one command). Tier 2 is about **doing things repeatedly** (loops),
> **packaging reusable logic** (functions), and **slicing text** (`grep`/`sed`/`awk`)
> — the actual day-job of a DevOps engineer. You don't need to master all of it
> now; skim it, then come back to each section as its day arrives.

## Section 1 — Loops: `for`, `while`, `until`

Three loop shapes. You'll use `for` most.

#### `for` — loop over a list of things

```bash
for i in 1 2 3; do echo "$i"; done          # explicit list
for i in {1..10}; do echo "$i"; done         # brace RANGE -> 1..10
for i in $(seq 1 10); do echo "$i"; done      # seq does the same
for f in *.log; do echo "$f"; done            # a GLOB (each matching file)
for arg in "$@"; do echo "$arg"; done         # the script's arguments (Day 10)
```

- `{1..10}` is **brace expansion** (Day 0 §8) — also `{1..10..2}` (step 2),
  `{a..e}`. It must be *literal* — `{1..$n}` does **not** work (use `seq` then).
- **C-style `for`** (like Python/C), great when you need arithmetic control:
  ```bash
  for (( i=1; i<=10; i++ )); do echo "$i"; done
  ```

#### `while` — loop *while* a condition is true

```bash
i=1
while (( i <= 10 )); do
    echo "$i"
    (( i++ ))              # remember the ++ gotcha (Day 3 §8)
done
```

`while` is also how you read a file line by line (Section 9) and how you build
retry loops (Day 29).

#### `until` — loop *until* a condition becomes true (rarely used)

```bash
until (( i > 10 )); do echo "$i"; (( i++ )); done   # opposite of while
```

#### Loop control

| Keyword    | Effect                                  |
|------------|-----------------------------------------|
| `break`    | exit the loop immediately               |
| `continue` | skip to the next iteration              |
| `break 2`  | break out of **2** nested loops         |

> ⚠️ **The no-match glob trap (Day 17):** `for f in *.log` — if there are **no**
> `.log` files, bash leaves the pattern **literal**, so `f` becomes the string
> `*.log`. Always guard: `[[ -e "$f" ]] || continue` inside the loop, or set
> `shopt -s nullglob` so a no-match expands to nothing.

## Section 2 — Functions

A **function** is a named, reusable block. Two ways to define (identical):

```bash
greet() {                 # preferred style
    echo "Hello, $1"      # $1 = first arg TO THE FUNCTION (not the script)
}

function greet {  ...  }  # older style, same thing
```

Call it like a command: `greet Mahima` (no parentheses, args space-separated).

#### Arguments inside a function

Inside a function, `$1 $2 $@ $#` refer to the **function's** arguments, not the
script's — the same positional-parameter rules as Day 2.

```bash
add() { echo $(( $1 + $2 )); }
add 3 4                    # prints 7
```

#### The TWO ways a function "returns" something — this trips everyone up

| You want to return… | Use          | Caller reads it with |
|---------------------|--------------|----------------------|
| a **success/fail**  | `return 0` / `return 1` (exit code) | `if myfunc; then` |
| a **value** (text/number) | `echo` the value | `x=$(myfunc)` (capture) |

```bash
is_even() { (( $1 % 2 == 0 )); }        # exit code: true if even (Day 19)
if is_even 4; then echo "even"; fi

double() { echo $(( $1 * 2 )); }         # VALUE via echo (Day 33)
result=$(double 7)                        # capture -> 14
```

> `return` only sets an **exit code (0–255)** — it can NOT hand back a string or
> a big number. To return data, `echo` it and capture with `$( )`. Verified.

#### `local` — keep variables inside the function

```bash
myfunc() {
    local tmp="only visible in here"     # without 'local' it leaks to global!
}
```
Always declare function-internal variables `local` so they don't clobber
globals — a classic senior-level habit (Day 20, Day 58).

## Section 3 — The text-processing toolkit: which tool when?

Tier 2's heart. Four tools overlap; pick by the job:

| Tool   | Best at…                                        | Reach for it when |
|--------|-------------------------------------------------|-------------------|
| `grep` | **finding** lines that match a pattern          | "show/count lines containing X" |
| `cut`  | pulling **fixed columns** by delimiter          | "give me field 3 of a CSV" |
| `awk`  | **field-by-field** logic, math, conditionals    | "sum column 2 where column 1 = X" |
| `sed`  | **editing** a stream (find/replace, delete)     | "replace X with Y", "delete blank lines" |
| `sort` `uniq` `wc` | ordering, de-duping, counting       | almost always at the end of a pipe |

The magic is **combining** them with pipes `|` (Day 0 §7):
```bash
cat access.log | grep " 404 " | awk '{print $1}' | sort | uniq -c | sort -rn
#                └ find 404s    └ pull the IP      └ group+count └ most first
```
This one line = "top IP addresses hitting 404s" (basically Day 23).

## Section 4 — `grep` (find lines by pattern)

`grep PATTERN file` prints every **line** that matches PATTERN. It's the single
most-used text tool in DevOps — searching logs, configs, code, command output.

```bash
grep "ERROR" app.log        # lines containing ERROR
grep "ERROR" *.log          # search many files (output is prefixed with filename)
command | grep "ERROR"      # filter another command's output (very common)
```

#### The essential flags

| Flag | Meaning | Example |
|------|---------|---------|
| `-i` | case-**i**nsensitive (`error`=`ERROR`) | `grep -i error log` |
| `-c` | **c**ount matching **lines** (a number) | `grep -c ERROR log` |
| `-v` | in**v**ert — lines that **don't** match | `grep -v DEBUG log` |
| `-n` | show line **n**umbers | `grep -n ERROR log` |
| `-r` | **r**ecursive through a directory tree | `grep -r TODO .` |
| `-l` | **l**ist only the **filenames** that match | `grep -rl TODO .` |
| `-w` | match whole **w**ords only | `grep -w warn log` |
| `-x` | match whole **lines** only (exact) | `grep -x DONE log` |
| `-o` | print **o**nly the matched text, not the line | `grep -o '[0-9]*' log` |
| `-q` | **q**uiet — no output, just the exit code | `grep -q ERROR log` |
| `-E` | **E**xtended regex (enables `\|` `()` `+` `?`) | `grep -E 'ERR\|WARN'` |
| `-A n` | print n lines **A**fter each match | `grep -A2 ERROR log` |
| `-B n` | print n lines **B**efore each match | `grep -B2 ERROR log` |
| `-C n` | print n lines of **C**ontext (before+after) | `grep -C2 ERROR log` |

> ⚠️ **Case matters:** `-c` (lowercase) = **count**; `-C` (uppercase) = **context**.
> A very common mix-up (you hit it in Day 22).

#### grep's exit code — why it works inside `if`

`grep` reports whether it found anything through its **exit status** — which is
what lets you use it as a condition (like Day 9's `id`):

| Exit code | Meaning |
|-----------|---------|
| `0` | at least one line **matched** |
| `1` | **no** lines matched |
| `2` | an **error** (e.g. file not found) |

```bash
if grep -q "ERROR" app.log; then       # -q = silent, just the exit code
    echo "errors found!"
fi
```
> Verified: `grep -q` returned `0` when found, `1` when not. Pair `-q` with `if`
> whenever you only care *whether* something exists, not what it is.

#### Counting: lines vs occurrences (the Day 22 lesson)

| Command | Counts | A line with 3 matches counts as |
|---------|--------|--------------------------------|
| `grep -c "warn" f`         | matching **lines**       | 1 |
| `grep -o "warn" f \| wc -l`| total **occurrences**    | 3 |

`-c` answers "how many lines contain it"; `-o` + `wc -l` answers "how many times
total." Verified: same file gave `-c`=3 vs occurrences=5.

#### Context — reading *around* a match (`-A` / `-B` / `-C`)

Great for logs: see what happened just before/after an error.

```bash
grep -A3 "Exception" app.log     # the match + 3 lines after (the stack trace)
grep -B2 "ERROR"     app.log     # 2 lines of lead-up before each error
grep -C2 "ERROR"     app.log     # 2 lines both sides
```
In the output, a `:` after the line marks the **match**, a `-` marks **context**.

#### Anchors & precision

Make patterns exact so you don't over-match substrings:

| Pattern   | Matches                              |
|-----------|--------------------------------------|
| `^ERROR`  | lines **starting** with ERROR        |
| `done$`   | lines **ending** with done           |
| `^$`      | **empty** lines                      |
| `^\s*#`   | comment lines (Day 26)               |
| `-w warn` | `warn` as a whole word (not `warning`) |
| `-x DONE` | a line that is **exactly** `DONE`    |

#### Regex: basic vs extended (`-E`)

- **Basic** grep: `.` `*` `^` `$` `[]` work; but `+` `?` `|` `()` need backslashes
  (`\+`, `\|`, `\(`).
- **`-E`** (extended, aka `egrep`): `+` `?` `|` `()` work **without** backslashes.
  Use `-E` whenever your pattern has alternation or groups:

```bash
grep -E "ERROR|WARN|FATAL" app.log        # any of the three
grep -E "^[0-9]{4}-[0-9]{2}-[0-9]{2}" log  # lines starting with a date
grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" access.log   # pull IPs (Day 23)
```
> `-P` (Perl regex, `\d` `\b` lookaheads) exists on Linux GNU grep but **not** on
> macOS BSD grep — prefer `-E` for portability.

#### Real-world one-liners you'll actually use

```bash
grep -rn "TODO" src/                     # every TODO with file:line
grep -c ERROR app.log                    # error count (Day 22)
grep -v "^#" config | grep -v "^$"       # drop comments and blanks (Day 26)
grep -i "failed" *.log                   # case-insensitive across logs
ps aux | grep -v grep | grep nginx       # find nginx processes (skip the grep itself)
grep -A5 "panic" app.log                 # a crash + the 5 lines after it
grep -oE "[0-9.]+" access.log | sort | uniq -c   # count numeric tokens
```

#### Key takeaways
- `grep PATTERN file` finds **lines**; `-i` ignore case, `-v` invert, `-n` numbers,
  `-r` recursive, `-w` whole word.
- **Exit code:** 0=found, 1=not found → use `grep -q` inside `if`.
- **`-c` = lines**, `-o | wc -l` = occurrences. `-c` ≠ `-C` (context).
- **`-E`** for `|`, `()`, `+`, `?` without backslashes. Anchor with `^`/`$`/`-w`.

## Section 5 — `sed` (stream editor: find/replace, delete)

The one you'll use 90% of the time is **substitution**:

```bash
sed 's/localhost/0.0.0.0/'  conf         # replace FIRST localhost per line
sed 's/localhost/0.0.0.0/g' conf         # g = ALL on each line (global)
sed -n '5,10p' file                       # -n + p = print only lines 5–10
sed '/^#/d' file                          # d = DELETE comment lines
sed '/^$/d' file                          # delete blank lines
```

Anatomy of `s/old/new/g`: **s**ubstitute, `/` separators, `g` = global flag.

#### ⚠️ The big macOS vs Linux gotcha: in-place editing `-i` (Day 25)

`-i` edits the file **in place**, but the syntax differs by platform:

| Platform            | Command                                   |
|---------------------|-------------------------------------------|
| **Linux** (GNU sed) | `sed -i 's/a/b/' file` (no backup)        |
| **Linux** + backup  | `sed -i.bak 's/a/b/' file`                |
| **macOS** (BSD sed) | `sed -i '' 's/a/b/' file`  ← **needs the `''`** |
| **macOS** + backup  | `sed -i.bak 's/a/b/' file`                |

> On your Mac, `sed -i 's/a/b/' file` **errors** — BSD `-i` requires a backup
> suffix argument (use `''` for none). Verified. `sed -i.bak` is the **portable**
> form that works on both. This exact trap is Day 25.

## Section 6 — `awk` (field-by-field processing)

`awk` treats each line as **fields** split on whitespace (or `-F` delimiter).
`$1` = first field, `$2` = second, … `$0` = whole line, `NF` = number of fields,
`NR` = current line number.

```bash
awk '{print $1}'  file             # first field of each line
awk -F, '{print $1, $3}' data.csv  # -F, = comma-separated (CSV) -> Day 24
awk '{print NR": "$0}' file         # prepend line numbers
awk '$3 > 100' file                 # print lines where field 3 > 100
awk '/ERROR/ {print $2}' file       # for lines matching /ERROR/, print field 2
awk '{sum += $1} END {print sum}'   # RUNNING TOTAL of column 1
```

- **`BEGIN { }` / `END { }`** run once before / after all lines — perfect for
  headers and totals.
- Built-in vars: `NR` (line number), `NF` (field count), `$NF` (last field).

> Verified: `awk -F, '{print $1, $3}'` on `alice,30,NYC` printed `alice NYC`.
> `awk` is a whole language, but 90% of DevOps use is "print/filter/sum a column."

## Section 7 — `cut`, `sort`, `uniq` (the pipeline finishers)

```bash
cut -d, -f1,3 data.csv       # -d = delimiter, -f = fields 1 and 3 (Day 24)
cut -d: -f1 /etc/passwd       # usernames (Day 9 used this)

sort file                     # alphabetical
sort -n file                  # -n = NUMERIC sort (10 after 9, not before)
sort -r file                  # -r = reverse
sort -k2 file                 # sort by 2nd field
sort -t, -k3 -n data.csv      # -t = field separator, sort by field 3 numerically

uniq file                     # collapse ADJACENT duplicate lines
uniq -c file                  # -c = prefix each line with its COUNT
```

> ⚠️ `uniq` only collapses **adjacent** duplicates — you must **`sort` first**.
> The classic "count by frequency" idiom (Day 23) is:
> ```bash
> sort | uniq -c | sort -rn      # group, count, then most-frequent first
> ```
> Verified: it correctly found `3 10.0.0.1` as the top IP.

- `cut` vs `awk`: `cut` is simpler for fixed delimiters; `awk` when you need logic
  or whitespace-runs as one separator.

## Section 8 — Reading a file line by line

The **correct**, safe idiom (Day 21) — memorize this exact line:

```bash
while IFS= read -r line; do
    echo "len=${#line}: $line"
done < file
```

| Piece            | Why it's there                                            |
|------------------|-----------------------------------------------------------|
| `IFS=`           | don't trim leading/trailing whitespace (Day 4 §1)         |
| `read -r`        | don't let `\` act as an escape (keep text literal)        |
| `< file`         | feed the file into the loop's stdin                       |
| `${#line}`       | length of the line (Day 21 needs "lines longer than 80")  |

> ⚠️ **Interview favorite (Day 52):** never do `for line in $(cat file)` — it
> splits on **spaces**, not lines, and globs. `while IFS= read -r` is the only
> correct way. Verified line-by-line with `${#line}` lengths.

## Section 9 — Parameter expansion (string surgery, no external tools)

Bash can slice strings itself — faster and safer than calling `basename`/`dirname`.
Given `p="/var/log/nginx/access.log"`:

| Expansion       | Result             | Meaning                          |
|-----------------|--------------------|----------------------------------|
| `${p##*/}`      | `access.log`       | strip longest `*/` → **filename** |
| `${p%/*}`       | `/var/log/nginx`   | strip shortest `/*` → **directory** |
| `${name%.*}`    | `access`           | strip extension → **basename**   |
| `${name##*.}`   | `log`              | the **extension**                |
| `${#p}`         | `25`               | **length** of the string         |
| `${p:-default}` | value, or `default` if unset | provide a **fallback** |
| `${p/old/new}`  | replace first `old` | in-string substitution          |

Memory trick: **`#` cuts from the front** (# is left of $ on the keyboard),
**`%` cuts from the back**; **doubled** (`##`/`%%`) = greedy (longest match).
This is exactly Day 27. Verified all of the above.

## Section 10 — `getopts` (proper flag parsing — Day 35)

For real CLI flags like `-e prod -v -h`, don't hand-parse `$1`/`$2` — use the
built-in `getopts`:

```bash
verbose=0
while getopts "e:vh" opt; do        # "e:vh" = valid flags; ':' means -e takes a value
    case "$opt" in
        e) env="$OPTARG" ;;          # $OPTARG holds -e's value
        v) verbose=1 ;;
        h) echo "usage..."; exit 0 ;;
        *) echo "bad flag" >&2; exit 1 ;;
    esac
done
shift $((OPTIND - 1))                # drop parsed flags, leaving positional args
```

| Piece      | Meaning                                             |
|------------|-----------------------------------------------------|
| `"e:vh"`   | flags `-e -v -h`; the `:` after `e` = **needs an argument** |
| `$OPTARG`  | the value given to a flag that takes one            |
| `$OPTIND`  | index of the next arg — used by `shift` at the end  |

> Verified: parsed `-e prod -v` into `env=prod` and `verbose on`. This is a
> **senior-must-know** — production scripts use `getopts`, not `$1` guessing.

## Section 11 — Networking & real-world commands you'll meet

Tier 2 dips into networking and cluster tooling. What you need to know:

#### IPv4 addresses (Day 32)
- Format: **four numbers (octets) 0–255**, dot-separated: `192.168.1.10`.
- Validating means: 4 groups of digits, **each ≤ 255** — a regex alone isn't
  enough (regex can match `999`); you also check each octet's value with
  `BASH_REMATCH` (Day 3 §5) capturing the four parts.

#### `ping` (Day 34)
```bash
ping -c 1 host        # -c 1 = send just ONE packet (else it runs forever)
```
Exit code `0` = reachable, non-zero = not (an exit-code check, like Day 9/12).

> ⚠️ macOS vs Linux: the **timeout** flag differs. Linux `-W 1` = wait 1 **second**;
> macOS `-W` is in **milliseconds** (and also has `-t` for total timeout). So
> `ping -c1 -W1` behaves differently per platform — check `man ping`. Use `-c 1`
> (portable) and add the timeout flag your platform expects.

#### `find` (Day 31) — recursive file search + actions
```bash
find . -type f -name "*.log"          # all .log files, recursively
find . -type f -exec du -h {} +        # run du on each found file ({} = the file)
find /tmp -type f -mtime +7 -delete    # files older than 7 days (Day 36 later)
```
`-exec ... {} +` feeds the found files into a command — combine with `sort` for
"5 largest files" (Day 31).

#### `kubectl` (Day 28) — Kubernetes CLI
```bash
kubectl get ns                  # list namespaces
kubectl get pods -n <namespace> # pods in a namespace
```
> ⚠️ The output has a **header row** (`NAME  STATUS ...`) — skip it when looping
> (`tail -n +2`, or `--no-headers`). You need a real cluster to run this; it's
> about **parsing command output** (Day 28), the skill that matters.

#### `seq` and date math (Days 29, 30)
- `seq 1 "$N"` → generate `1..N` for a counted retry loop (Day 29).
- Date arithmetic for "last 24 hours" (Day 30): Linux `date -d '24 hours ago' +%s`
  vs macOS `date -v-24H +%s` (Day 6 §6). Compare Unix timestamps (`+%s`).

## Section 12 — Habits to carry into every Tier 2 script

- **Quote everything:** `"$var"`, `"$@"`, `"$f"` — globs and spaces bite hardest
  in loops (Day 10).
- **Guard no-match globs:** `for f in *.log` can yield the literal `*.log`
  (Section 1).
- **Validate + fail fast:** arg checks, `>&2`, `exit 1` — the Tier 1 habit still
  applies (Days 8, 9, 14).
- **`local` in functions** to avoid leaking variables (Section 2).
- **Prefer parameter expansion** over spawning `basename`/`dirname`/`cut` when
  you're just slicing one string (Section 9) — fewer processes, faster.
- **`while IFS= read -r`**, never `for line in $(cat)` (Section 8).
- **Know your platform:** `sed -i`, `date`, and `ping` flags differ macOS↔Linux.
  Write for Linux (the server), know the macOS form to test locally.

#### Tier 2 key takeaways
- `for` for lists/globs/ranges, `while` for conditions and reading files.
- Functions return **status** via `return`/exit code, **data** via `echo` + `$( )`.
- `grep` finds, `cut` slices columns, `awk` does field logic/math, `sed` edits.
- `sort | uniq -c | sort -rn` = count-by-frequency; `uniq` needs a `sort` first.
- `${##}`/`${%%}` slice paths; `getopts` parses real flags; quote everything.

---

## Day 19 — Functions in Bash (end to end)

> The Tier 2 primer §2 is the quick overview; this is the **full reference**.
> Functions are how you stop repeating yourself and start building reusable,
> readable scripts. Master this — every serious script from here uses functions.

### Section 1 — What a function is & why use one

A **function** is a **named block of commands** you can run over and over by name.
Instead of copy-pasting the same 5 lines everywhere, you write them once and call
them.

```bash
greet() {
    echo "Hello there!"
}

greet        # run it — prints "Hello there!"
greet        # run it again
```

Why they matter:
- **Don't Repeat Yourself** — write logic once, call it many times.
- **Readability** — `if is_valid_ip "$x"` reads like English vs a wall of regex.
- **Testable & composable** — small functions combine into bigger scripts (Day 58's
  `lib.sh`, Day 60's orchestrator).

### Section 2 — Defining & calling functions

Two syntaxes — **identical** in behaviour; the first is preferred:

```bash
name() {          # ← preferred (POSIX)
    commands
}

function name {   # ← older bash-only style, same result
    commands
}
```

**Calling** is just the name, like any command — **no parentheses, args separated
by spaces**:

```bash
greet Mahima          # ✅ correct
greet("Mahima")       # ❌ this is NOT how bash calls functions
```

> ⚠️ A function must be **defined before it's called** — bash reads top to bottom.
> Put your functions near the top, and the "main" logic below them.

### Section 3 — Arguments inside a function

A function gets its **own** positional parameters — the same `$1`, `$2`, `$@`,
`$#` rules as a script (Day 2), but scoped to the **function's** call, not the
script's.

```bash
add() {
    echo "got $# args: $@"
    echo $(( $1 + $2 ))
}
add 3 4          # got 2 args: 3 4  /  7
```

| Inside a function | Means |
|-------------------|-------|
| `$1`, `$2`, …     | the function's 1st, 2nd, … argument |
| `$@`              | all the function's args (each quoted separately) |
| `$#`              | how many args the function got |
| `$0`              | still the **script** name (not the function) |
| `${FUNCNAME[0]}`  | the current function's **name** (verified) |

#### `shift` — consume arguments from the front

`shift` **drops `$1` and slides everything down** (`$2`→`$1`, `$3`→`$2`, …). Great
when the first arg is special and the rest is "everything else" (Day 20's `log`):

```bash
log() {
    local level="$1"      # first arg = level
    shift                  # drop it
    echo "[$level] $*"     # $* = the remaining words (the message)
}
log INFO "server started"   # [INFO] server started
```

### Section 4 — The TWO ways a function "returns" (the big one)

This is the #1 thing beginners get wrong. Bash functions return in **two totally
different ways**, depending on whether you want a **status** or a **value**:

| You want to return… | Use              | Caller reads it with     |
|---------------------|------------------|--------------------------|
| success / failure (yes-no) | `return N` (exit code) | `if myfunc; then` |
| a **value** (string/number) | `echo` the value | `x=$(myfunc)` (capture)  |

#### Way 1 — `return` = an exit code (status only)

```bash
is_even() {
    if (( $1 % 2 == 0 )); then
        return 0        # 0 = success = "true"
    else
        return 1        # non-zero = failure = "false"
    fi
}

if is_even 4; then echo "even"; fi     # uses the exit code as the condition
```

> ⚠️ **`return` can ONLY hold a number 0–255** (it's an exit **code**, not a value).
> Bigger numbers **wrap around** — verified: `return 256`→`0`, `return 300`→`44`,
> `return -1`→`255`. So you can **never** use `return` to hand back real data.

#### Way 2 — `echo` + capture = a value

To return actual data (a number over 255, a string, a computed result), **`echo`
it** and have the caller **capture** it with command substitution (Day 13):

```bash
double() {
    echo $(( $1 * 2 ))      # "return" the value by printing it
}

result=$(double 7)          # capture -> 14
echo "$result"
```

> Key mental model: `return` answers **"did it work?"**; `echo`+`$()` answers
> **"what's the value?"**. Mixing them up is the classic bug — e.g. writing
> `return $(( $1 * 2 ))` for a big number silently wraps past 255.

### Section 5 — Variable scope: `local` vs global

By default, **all** variables in bash are **global** — a variable set inside a
function leaks out and can clobber the rest of your script:

```bash
name="global"
leaky()  { name="LEAKED"; }        # no 'local' → overwrites the global!
leaky;   echo "$name"               # LEAKED   ⚠️

safe()   { local name="inside"; }   # 'local' → confined to the function
safe;    echo "$name"               # still "global"  ✅
```

> **Always declare a function's own variables `local`.** Verified above: without
> `local`, `name` leaked; with it, the global was untouched. This prevents
> maddening bugs where a helper function silently changes a variable the caller
> was using (a real senior-level habit — Day 58).

### Section 6 — The Day 19 worked example

Task: a function `is_even` that returns success/failure via exit code, used in a
loop over 1–20.

```bash
#!/bin/bash

is_even() {
    (( $1 % 2 == 0 ))       # (( )) sets the exit code: 0 if even, 1 if odd
}

for i in {1..20}; do
    if is_even "$i"; then
        echo "$i is even"
    fi
done
```

Two equivalent forms of the function:
```bash
is_even() { (( $1 % 2 == 0 )); }          # concise — relies on (( )) exit code

is_even() {                                # explicit — spells out return
    if (( $1 % 2 == 0 )); then return 0; else return 1; fi
}
```
Both work because `(( ))` already sets its exit status from the result (Day 3 §3).
The function then plugs straight into `if is_even "$i"` — the function **is** the
condition (see Day 9/12 for the same command-exit-status idea).

### Section 7 — Gotchas & best practices

- **Define before you call** — functions must appear above their first use.
- **`local` your variables** — or they leak into the global scope (§5).
- **`return` is 0–255 only** — for data, `echo` + `$()` (§4). Don't `return` a
  computed value that might exceed 255.
- **Quote the args** — `myfunc "$var"`, and inside use `"$1"`, `"$@"` (Day 10).
- **One job per function** — small, named, testable. Compose them.
- **A common structure** for bigger scripts: helper functions up top, then a
  `main()` function, then a single `main "$@"` call at the bottom (Day 56).

```bash
main() {
    # top-level logic here
    log INFO "starting"
    ...
}
main "$@"        # pass the script's args into main
```

#### Key takeaways
- Define with `name() { ... }`; call with just `name arg1 arg2` (no parens).
- Inside, `$1`/`$@`/`$#` are the **function's** args; `shift` consumes from the front.
- **Return status** with `return` (0–255 exit code) → use in `if`.
- **Return data** with `echo` → capture with `$( )`.
- Always `local` a function's variables to avoid leaks.

---

## Day 21 — Reading files line by line & string length

> Two new tools: the `while IFS= read -r line` idiom (the *only* correct way to
> read a file line by line) and `${#var}` (string length). The Tier 2 primer §8
> introduced them; this is the full breakdown, including the edge cases that make
> them interview favorites.

### Section 1 — The `read` command, in depth

`read` reads **one line** from its input into a variable, and its **exit status**
tells you whether it got one:

- Returns **`0`** (success) each time it reads a line.
- Returns **non-zero** when it hits **end-of-file** (nothing left).

That success/failure is what drives the `while` loop — it keeps going until
`read` fails at EOF (verified):

```bash
while IFS= read -r line; do
    echo "$line"
done < file
```

`read` on its own (from Day 4 §1) waits for keyboard input; here we redirect a
**file** into it with `< file`, so it reads the file instead.

### Section 2 — The `while IFS= read -r line` idiom, dissected

Every piece of this line is there for a reason — leave one out and you get subtle
bugs:

```bash
while IFS= read -r line; do ... done < file
```

| Piece      | What it does | What breaks without it |
|------------|--------------|------------------------|
| `while`    | loop as long as `read` succeeds (a line was read) | — |
| `IFS=`     | set field separator to **empty** for this command | leading/trailing **spaces get trimmed** off each line |
| `read`     | read one line into a variable | — |
| `-r`       | **raw** mode | a `\` in the line is treated as an **escape** and mangled |
| `line`     | the variable the line lands in | — |
| `< file`   | feed the file into `read`'s stdin | reads from the keyboard instead |

- **`IFS=`** — `IFS` (Internal Field Separator) is what bash splits on. Setting it
  empty **just for this command** (the `IFS= read` prefix) means the whole line,
  spaces and all, goes into `line` untouched.
- **`-r`** — without it, a line containing `a\tb` would have its `\` interpreted.
  `-r` keeps text **literal**. (You verified this back in Day 4 §1.)

> Placing `IFS=` right before `read` on the same line sets it **only for that
> command** — it doesn't change `IFS` for the rest of the script. A clean trick.

### Section 3 — ⚠️ The last-line-without-a-newline trap

A file's last line sometimes has **no trailing newline** (many editors, `printf`
without `\n`, some logs). Plain `while read` **silently skips that last line** —
because `read` reads the text but returns **non-zero** (EOF) at the same moment,
so the loop body never runs for it.

```bash
printf 'line1\nline2\nlast'    # 'last' has NO newline after it

while IFS= read -r line; do echo "$line"; done   # prints line1, line2 — MISSES 'last' ❌
```

The fix — also run the body when `read` failed **but** still put something in
`line`:

```bash
while IFS= read -r line || [[ -n "$line" ]]; do
    echo "$line"
done < file
```

> Verified: the plain loop dropped `last`; the `|| [[ -n "$line" ]]` version caught
> it. This is a classic gotcha — worth knowing for interviews and for real log
> files that don't end in a newline.

### Section 4 — String length with `${#var}`

`${#var}` gives the **number of characters** in a variable:

```bash
s="hello"
echo "${#s}"          # 5
echo "${#EMPTY}"      # 0  (unset or empty -> 0)
```

| Expansion       | Gives you                                  |
|-----------------|--------------------------------------------|
| `${#var}`       | length of the string (character count)     |
| `${#1}`         | length of the **1st argument**             |
| `${#arr[@]}`    | number of **elements** in an array         |
| `${#line}`      | length of the current line (Day 21's core) |

- Verified: `${#s}`=5, `${#EMPTY}`=0, `${#arr[@]}`=4.
- Counts **characters**, not bytes — in a UTF-8 locale a 3-byte emoji counts as 1.
- It's **parameter expansion** (primer §9), so it's instant — no `wc -c` subprocess.

Then a length test is just arithmetic (Day 3 §7):
```bash
if (( ${#line} > 80 )); then ...      # lines longer than 80 chars
```

### Section 5 — Why `for line in $(cat file)` is WRONG

The tempting-but-broken alternative — **never use it**:

```bash
for line in $(cat file); do ... done    # ❌
```

- `for` iterates over **words**, not lines — `$(cat file)` is split on **spaces**
  (via `IFS`), so a line `hello world` becomes **two** iterations.
- It also **glob-expands** — a line containing `*` turns into filenames.

`while IFS= read -r` is the only correct way. This exact contrast is Day 52, a
senior-interview staple.

### Section 6 — The Day 21 solution

Task: print lines **longer than 80 characters**, with their line numbers.

```bash
#!/bin/bash

file=$1
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <file>" >&2
    exit 1
fi
if [[ ! -f "$file" ]]; then
    echo "Error: '$file' is not a file" >&2
    exit 1
fi

n=0
while IFS= read -r line; do
    (( ++n ))                        # PRE-increment: safe under set -e (Day 3 §8)
    if (( ${#line} > 80 )); then
        echo "$n: $line"
    fi
done < "$file"
```

- **Take the file as `$1`** and validate it (`-f`) — don't hardcode a filename.
- **`(( ++n ))`** not `(( n++ ))`: starting from 0, post-increment returns exit 1
  on the first pass, which would abort under `set -e` (Day 3 §8).
- `(( ${#line} > 80 ))` — length check; `> 80` means "longer than 80" (80 itself
  is *not* printed). Verified against exact-80 / 81 / 100-char lines.

#### Key takeaways
- `while IFS= read -r line; do ... done < file` — memorize it exactly.
- `IFS=` preserves whitespace; `-r` keeps backslashes literal; `< file` is the input.
- Guard the **last line without a newline** with `|| [[ -n "$line" ]]`.
- `${#var}` = length (characters); `${#arr[@]}` = array size.
- Never `for line in $(cat file)` — it splits on words and globs.

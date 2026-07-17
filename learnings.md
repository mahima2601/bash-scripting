# My Bash Learnings

A running log of what I learn each day. One section per day.
The actual code for each day lives in `N_day.sh`; this file is the *theory*.

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

- `-e` — true if the file or directory exists.
- `-f` — true if it exists and is a **regular file** (not a folder).
- `-d` — true if the path is a **directory**.

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

Breaking down the regex `^-?[0-9]+$`:

| Part     | Meaning                                    |
|----------|--------------------------------------------|
| `^`      | start of the string                        |
| `-?`     | an optional minus sign (for negatives)     |
| `[0-9]+` | one or more digits                         |
| `$`      | end of the string                          |

The `^` and `$` anchors matter — without them, `12abc` would wrongly pass because
the regex would match just the `12` part.

> Note: `=~` only works inside `[[ ]]`, never inside single `[ ]`. This is one of
> the main reasons to prefer `[[ ]]` in Bash.

#### Key takeaways
- Bash arithmetic is **integer only** — `/` truncates, never rounds.
- Empty or non-numeric variables silently become `0` — **always validate**.
- Division by zero is a **fatal error** — guard it before dividing.
- Send errors to stderr with `>&2` and `exit 1` (Day 2, Section 4).

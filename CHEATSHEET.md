# Bash Scripting Cheat Sheet

A quick-reference guide for DevOps shell scripting.

---

## Basics

```bash
#!/bin/bash          # shebang — always first line
chmod +x script.sh   # make executable
./script.sh          # run script
bash script.sh       # run without chmod
```

---

## Variables

```bash
NAME="DevOps"            # declare (no spaces around =)
echo "$NAME"             # use variable
echo "${NAME}"           # safer with braces
echo 'literal $NAME'     # single quotes = no expansion

readonly PI=3.14         # constant
unset NAME               # delete variable
```

---

## User Input

```bash
read NAME                          # basic input
read -p "Enter name: " NAME        # with prompt
read -sp "Password: " PASS         # silent (passwords)
read -p "Name and age: " NAME AGE  # multiple values
```

---

## Arguments

```bash
$0   # script name
$1   # first argument
$2   # second argument
$#   # number of arguments
$@   # all arguments (separate)
$*   # all arguments (single string)
$?   # exit status of last command
$$   # current process ID
```

---

## Conditionals

```bash
if [ condition ]; then
    # commands
elif [ condition ]; then
    # commands
else
    # commands
fi
```

### String Operators
```bash
[ "$a" = "$b" ]    # equal
[ "$a" != "$b" ]   # not equal
[ -z "$a" ]        # empty string
[ -n "$a" ]        # non-empty string
```

### Integer Operators
```bash
[ $a -eq $b ]   # equal
[ $a -ne $b ]   # not equal
[ $a -lt $b ]   # less than
[ $a -gt $b ]   # greater than
[ $a -le $b ]   # less than or equal
[ $a -ge $b ]   # greater than or equal
```

### File Operators
```bash
[ -f file ]   # is a regular file
[ -d dir ]    # is a directory
[ -e path ]   # exists (file or dir)
[ -r file ]   # readable
[ -w file ]   # writable
[ -x file ]   # executable
[ -s file ]   # exists and not empty
```

### Logical Operators
```bash
[ cond1 ] && [ cond2 ]   # AND
[ cond1 ] || [ cond2 ]   # OR
[ ! cond ]               # NOT
```

---

## Case Statement

```bash
case $var in
    pattern1)
        ;;
    pattern2|pattern3)
        ;;
    *)
        # default
        ;;
esac
```

---

## Loops

### For Loop
```bash
for i in {1..10}; do
    echo "$i"
done

for item in apple banana orange; do
    echo "$item"
done

for (( i=0; i<5; i++ )); do
    echo "$i"
done
```

### While Loop
```bash
while [ $n -gt 0 ]; do
    echo "$n"
    ((n--))
done
```

### Until Loop
```bash
until [ $n -gt 10 ]; do
    ((n++))
done
```

### Loop Control
```bash
break      # exit loop
continue   # skip to next iteration
```

### Loop Over Files
```bash
for file in *.log; do
    echo "$file"
done

find /var/log -name "*.log" | while read file; do
    echo "$file"
done
```

### Loop Over File Lines
```bash
while read line; do
    echo "$line"
done < file.txt
```

---

## Functions

```bash
greet() {
    local name=$1       # local variable
    echo "Hello, $name"
}

greet "Shashank"        # call function

# Capture return value
get_sum() {
    echo $(( $1 + $2 ))
}
result=$(get_sum 5 3)
```

---

## Arrays

```bash
arr=("a" "b" "c")       # declare
echo "${arr[0]}"         # first element
echo "${arr[@]}"         # all elements
echo "${#arr[@]}"        # length

for item in "${arr[@]}"; do
    echo "$item"
done
```

---

## Arithmetic

```bash
result=$(( 5 + 3 ))
result=$(( a * b ))
((counter++))
((counter--))
((counter += 5))
let result=5+3
```

---

## String Operations

```bash
${#str}              # string length
${str:0:5}           # substring (pos 0, len 5)
${str/old/new}       # replace first match
${str//old/new}      # replace all matches
${str^^}             # uppercase
${str,,}             # lowercase
${str:-default}      # use default if unset
```

---

## Redirections

```bash
cmd > file.txt        # stdout to file (overwrite)
cmd >> file.txt       # stdout to file (append)
cmd 2> err.log        # stderr to file
cmd &> all.log        # stdout + stderr to file
cmd > /dev/null 2>&1  # discard all output
cmd < file.txt        # stdin from file
```

---

## Pipes & Command Substitution

```bash
cmd1 | cmd2           # pipe stdout to next command
result=$(command)     # capture output
result=`command`      # older syntax (avoid)
```

---

## Text Processing

### grep
```bash
grep "pattern" file          # basic search
grep -i "error" file         # case-insensitive
grep -r "TODO" /dir          # recursive
grep -n "ERROR" file         # show line numbers
grep -c "ERROR" file         # count matches
grep -v "DEBUG" file         # invert (exclude)
grep -E "err|fail" file      # extended regex
grep -A 3 "ERROR" file       # 3 lines after match
grep -B 2 "ERROR" file       # 2 lines before match
```

### awk
```bash
awk '{print $1}' file              # first column
awk '{print $1, $3}' file          # columns 1 and 3
awk -F: '{print $1}' /etc/passwd   # custom delimiter
awk '/ERROR/ {print}' file         # pattern match
awk '{$1=$2=""; print}' file       # remove first 2 fields
awk 'NR>1 {print}' file            # skip first line
awk '$3 > 100 {print $1}' file     # conditional print
```

### sed
```bash
sed 's/old/new/' file          # replace first per line
sed 's/old/new/g' file         # replace all
sed -i 's/old/new/g' file      # in-place edit
sed '/pattern/d' file          # delete matching lines
sed -n '10,20p' file           # print lines 10-20
```

### cut / sort / uniq / wc
```bash
cut -d: -f1 /etc/passwd        # extract field 1
sort file                      # alphabetical sort
sort -n file                   # numerical sort
sort -rn file                  # reverse numerical
sort -u file                   # sort + deduplicate
uniq -c file                   # count occurrences
wc -l file                     # count lines
wc -w file                     # count words
head -n 5 file                 # first 5 lines
tail -n 5 file                 # last 5 lines
tail -f file                   # follow (real-time)
```

---

## Error Handling

```bash
set -e            # exit on error
set -u            # error on unset variable
set -o pipefail   # catch pipe failures
set -x            # debug/trace mode
set -euo pipefail # all combined (recommended)
```

```bash
cmd || { echo "failed"; exit 1; }   # inline error handling
cmd && echo "success"               # run if previous succeeded

trap cleanup EXIT    # run function on exit
trap 'rm -f /tmp/tmpfile' EXIT
```

---

## Exit Codes

```bash
exit 0   # success
exit 1   # general error
exit 2   # misuse of command

if [ $? -eq 0 ]; then
    echo "last command succeeded"
fi
```

---

## find

```bash
find /path -name "*.log"           # by name
find /path -type f                 # files only
find /path -type d                 # dirs only
find /path -mtime +7               # older than 7 days
find /path -mtime -1               # modified in last 1 day
find /path -name "*.log" -delete   # find and delete
find /path -name "*.log" -exec gzip {} \;   # find and exec
```

---

## Useful One-Liners

```bash
# disk usage alert
df / | awk 'NR==2 {print $5}' | sed 's/%//'

# top 5 error messages
grep "ERROR" app.log | sort | uniq -c | sort -rn | head -5

# backup with timestamp
tar -czf "backup_$(date +%Y%m%d).tar.gz" /source

# delete files older than 7 days
find /logs -name "*.log" -mtime +7 -delete

# check if service is running
systemctl is-active --quiet nginx && echo "up" || echo "down"

# replace string in all files
grep -rl "old" /path | xargs sed -i 's/old/new/g'

# count lines in all log files
find . -name "*.log" | xargs wc -l | tail -1
```

---

## Cron Syntax

```
* * * * * command
│ │ │ │ └── day of week (0-7, 0=Sun)
│ │ │ └──── month (1-12)
│ │ └────── day of month (1-31)
│ └──────── hour (0-23)
└────────── minute (0-59)
```

```bash
0 2 * * *     # every day at 2 AM
*/5 * * * *   # every 5 minutes
0 * * * *     # every hour
0 0 1 * *     # first of every month
0 9 * * 1-5   # weekdays at 9 AM
0 3 * * 0     # every Sunday at 3 AM
```

---

## Script Template

```bash
#!/bin/bash
set -euo pipefail

usage() {
    echo "Usage: $0 <argument>"
    exit 1
}

cleanup() {
    echo "Cleaning up..."
}
trap cleanup EXIT

main() {
    [ $# -eq 0 ] && usage
    echo "Running..."
}

main "$@"
```

---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

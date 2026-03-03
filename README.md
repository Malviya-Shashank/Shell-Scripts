# Shell-Scripts
Shell Scripts for DevOps automation, system administration, and infrastructure operations.

# Shell Scripting Cheat Sheet

A comprehensive quick-reference guide based on practical DevOps scripting experience (Days 16-20).

---

## Quick Reference Table

| Topic | Key Syntax | Example |
|-------|-----------|---------|
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2`, `$#`, `$@` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop | `for i in list; do` | `for i in 1 2 3; do` |
| While loop | `while [ condition ]; do` | `while [ $n -gt 0 ]; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i "error" log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |
| Exit code | `$?` | `if [ $? -eq 0 ]; then` |

---

## 1. Basics

### Shebang
```bash
#!/bin/bash
```
Tells the system which interpreter to use. Always put it as the first line. Ensures consistency across different systems.

### Running a Script
```bash
# Make executable
chmod +x script.sh

# Run it
./script.sh

# Or run with bash directly
bash script.sh
```

### Comments
```bash
# This is a single-line comment

echo "Hello"  # Inline comment

<< 'COMMENT'
This is a
multi-line comment
block
COMMENT
```

### Variables
```bash
# Declaring variables (no spaces around =)
NAME="Shashank"
ROLE="DevOps Engineer"

# Using variables
echo "Hello, $NAME"
echo "Hello, ${NAME}"  # Safer with braces

# Double quotes - variable expansion
echo "My name is $NAME"  # Output: My name is Shashank

# Single quotes - literal text
echo 'My name is $NAME'  # Output: My name is $NAME
```

### Reading User Input
```bash
# Basic read
read NAME

# With prompt
read -p "Enter your name: " NAME

# Read multiple values
read -p "Enter name and age: " NAME AGE

# Silent input (for passwords)
read -sp "Enter password: " PASSWORD
```

### Command-Line Arguments
```bash
$0  # Script name
$1  # First argument
$2  # Second argument
$#  # Number of arguments
$@  # All arguments as separate items
$*  # All arguments as single string
$?  # Exit status of last command

# Example usage
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi
```

---

## 2. Operators and Conditionals

### String Comparisons
```bash
[ "$str1" = "$str2" ]   # Equal
[ "$str1" != "$str2" ]  # Not equal
[ -z "$str" ]           # String is empty
[ -n "$str" ]           # String is not empty

# Example
if [ "$choice" = "y" ]; then
    echo "Yes selected"
fi
```

### Integer Comparisons
```bash
[ $num1 -eq $num2 ]  # Equal
[ $num1 -ne $num2 ]  # Not equal
[ $num1 -lt $num2 ]  # Less than
[ $num1 -gt $num2 ]  # Greater than
[ $num1 -le $num2 ]  # Less than or equal
[ $num1 -ge $num2 ]  # Greater than or equal

# Example
if [ $age -gt 18 ]; then
    echo "Adult"
fi
```

### File Test Operators
```bash
[ -f file ]  # File exists and is regular file
[ -d dir ]   # Directory exists
[ -e path ]  # Path exists (file or directory)
[ -r file ]  # File is readable
[ -w file ]  # File is writable
[ -x file ]  # File is executable
[ -s file ]  # File exists and is not empty

# Example
if [ -f "config.txt" ]; then
    echo "Config file exists"
fi
```

### If-Elif-Else Syntax
```bash
if [ condition ]; then
    # commands
elif [ condition ]; then
    # commands
else
    # commands
fi

# Example
if [ $num -gt 0 ]; then
    echo "Positive"
elif [ $num -lt 0 ]; then
    echo "Negative"
else
    echo "Zero"
fi
```

### Logical Operators
```bash
# AND
if [ condition1 ] && [ condition2 ]; then

# OR
if [ condition1 ] || [ condition2 ]; then

# NOT
if [ ! condition ]; then

# Example
if [ -f "file.txt" ] && [ -r "file.txt" ]; then
    echo "File exists and is readable"
fi
```

### Case Statements
```bash
case $variable in
    pattern1)
        # commands
        ;;
    pattern2)
        # commands
        ;;
    *)
        # default case
        ;;
esac

# Example
case $choice in
    y|Y|yes)
        echo "Confirmed"
        ;;
    n|N|no)
        echo "Cancelled"
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
```

---

## 3. Loops

### For Loop - List-Based
```bash
# Loop through list
for item in apple banana orange; do
    echo "$item"
done

# Loop through array
fruits=("apple" "banana" "orange")
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done

# Loop through range
for i in {1..10}; do
    echo "$i"
done
```

### For Loop - C-Style
```bash
for (( i=1; i<=10; i++ )); do
    echo "$i"
done
```

### While Loop
```bash
counter=5
while [ $counter -gt 0 ]; do
    echo "$counter"
    ((counter--))
done
```

### Until Loop
```bash
counter=1
until [ $counter -gt 5 ]; do
    echo "$counter"
    ((counter++))
done
```

### Loop Control
```bash
# Break - exit loop
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        break
    fi
    echo "$i"
done

# Continue - skip to next iteration
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        continue
    fi
    echo "$i"
done
```

### Looping Over Files
```bash
# Loop through log files
for file in *.log; do
    echo "Processing $file"
    gzip "$file"
done

# Loop through files with find
find /var/log -name "*.log" -type f | while read file; do
    echo "Found: $file"
done
```

### Looping Over Command Output
```bash
# Read line by line
while read line; do
    echo "Line: $line"
done < file.txt

# With pipe
cat file.txt | while read line; do
    echo "$line"
done

# Read with IFS (Internal Field Separator)
grep -n "CRITICAL" log.txt | while IFS=: read -r line content; do
    echo "Line $line: $content"
done
```

---

## 4. Functions

### Defining a Function
```bash
# Method 1
function_name() {
    # commands
}

# Method 2
function function_name {
    # commands
}

# Example
greet() {
    echo "Hello, $1!"
}
```

### Calling a Function
```bash
greet "Shashank"

# With multiple arguments
add() {
    local sum=$(( $1 + $2 ))
    echo "$sum"
}

result=$(add 5 3)
echo "Result: $result"
```

### Passing Arguments to Functions
```bash
# Arguments work same as script arguments
function_name() {
    local arg1=$1
    local arg2=$2
    echo "Arg1: $arg1, Arg2: $arg2"
}

function_name "value1" "value2"
```

### Return Values
```bash
# Using return (only returns exit code 0-255)
check_file() {
    if [ -f "$1" ]; then
        return 0  # Success
    else
        return 1  # Failure
    fi
}

check_file "test.txt"
if [ $? -eq 0 ]; then
    echo "File exists"
fi

# Using echo (for actual values)
get_sum() {
    local result=$(( $1 + $2 ))
    echo "$result"
}

sum=$(get_sum 10 20)
echo "Sum is: $sum"
```

### Local Variables
```bash
# Without local - variable is global
function_bad() {
    counter=100
}

# With local - variable is scoped to function
function_good() {
    local counter=100
    echo "$counter"
}

function_good  # Prints 100
echo "$counter"  # Empty or previous value
```

---

## 5. Text Processing Commands

### grep - Search Patterns
```bash
grep "pattern" file.txt          # Basic search
grep -i "error" log.txt          # Case-insensitive
grep -r "TODO" /project          # Recursive search
grep -c "ERROR" log.txt          # Count matches
grep -n "CRITICAL" log.txt       # Show line numbers
grep -v "DEBUG" log.txt          # Invert match (exclude)
grep -E "error|fail" log.txt     # Extended regex (OR)
grep -A 3 "ERROR" log.txt        # Show 3 lines after match
grep -B 2 "ERROR" log.txt        # Show 2 lines before match
```

### awk - Text Processing
```bash
# Print specific columns
awk '{print $1}' file.txt                    # First column
awk '{print $1, $3}' file.txt                # First and third columns

# Custom field separator
awk -F: '{print $1}' /etc/passwd             # Use : as separator

# Pattern matching
awk '/ERROR/ {print $0}' log.txt             # Print lines with ERROR

# Remove first 3 fields
awk '{$1=$2=$3=""; print}' log.txt

# BEGIN and END blocks
awk 'BEGIN {print "Start"} {print $1} END {print "Done"}' file.txt

# Conditional processing
awk '$3 > 100 {print $1, $3}' data.txt       # Print if column 3 > 100
```

### sed - Stream Editor
```bash
# Substitution
sed 's/old/new/' file.txt                    # Replace first occurrence per line
sed 's/old/new/g' file.txt                   # Replace all occurrences
sed -i 's/old/new/g' file.txt                # In-place edit

# Delete lines
sed '/pattern/d' file.txt                    # Delete lines matching pattern
sed '5d' file.txt                            # Delete line 5
sed '1,3d' file.txt                          # Delete lines 1-3

# Print specific lines
sed -n '10,20p' file.txt                     # Print lines 10-20
```

### cut - Extract Columns
```bash
cut -d: -f1 /etc/passwd                      # Extract first field (: delimiter)
cut -d, -f1,3 data.csv                       # Extract columns 1 and 3
cut -c1-10 file.txt                          # Extract characters 1-10
```

### sort - Sort Lines
```bash
sort file.txt                                # Alphabetical sort
sort -r file.txt                             # Reverse sort
sort -n file.txt                             # Numerical sort
sort -rn file.txt                            # Reverse numerical sort
sort -u file.txt                             # Sort and remove duplicates
sort -k2 file.txt                            # Sort by second column
```

### uniq - Remove Duplicates
```bash
uniq file.txt                                # Remove adjacent duplicates
uniq -c file.txt                             # Count occurrences
uniq -d file.txt                             # Show only duplicates
uniq -u file.txt                             # Show only unique lines

# Common pattern: sort then uniq
sort file.txt | uniq -c | sort -rn           # Count and sort by frequency
```

### tr - Translate Characters
```bash
tr 'a-z' 'A-Z' < file.txt                    # Lowercase to uppercase
tr -d '0-9' < file.txt                       # Delete all digits
tr -s ' ' < file.txt                         # Squeeze multiple spaces to one
echo "hello" | tr 'l' 'L'                    # Replace specific character
```

### wc - Count Lines/Words/Characters
```bash
wc -l file.txt                               # Count lines
wc -w file.txt                               # Count words
wc -c file.txt                               # Count characters
wc -m file.txt                               # Count characters (multibyte)

# Example
total_lines=$(wc -l < file.txt)
```

### head / tail - First/Last Lines
```bash
head file.txt                                # First 10 lines (default)
head -n 5 file.txt                           # First 5 lines
tail file.txt                                # Last 10 lines
tail -n 20 file.txt                          # Last 20 lines
tail -f log.txt                              # Follow mode (real-time)
```

---

## 6. Useful Patterns and One-Liners

### Find and Delete Old Files
```bash
# Delete files older than 7 days
find /path -name "*.log" -mtime +7 -delete

# Or with exec
find /path -name "*.log" -mtime +7 -exec rm {} \;
```

### Count Lines in All Log Files
```bash
find . -name "*.log" -exec wc -l {} + | tail -1
```

### Replace String Across Multiple Files
```bash
# Using sed
find . -name "*.txt" -exec sed -i 's/old/new/g' {} \;

# Using grep and sed
grep -rl "old_text" /path | xargs sed -i 's/old_text/new_text/g'
```

### Check if Service is Running
```bash
# Method 1
systemctl is-active nginx && echo "Running" || echo "Stopped"

# Method 2
if systemctl is-active --quiet nginx; then
    echo "Nginx is running"
fi
```

### Monitor Disk Usage with Alert
```bash
# Alert if disk usage > 80%
df -h | awk '$5 > 80 {print "Alert: " $0}'

# Or in script
usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ $usage -gt 80 ]; then
    echo "Disk usage critical: ${usage}%"
fi
```

### Parse CSV from Command Line
```bash
# Extract specific columns
awk -F, '{print $1, $3}' data.csv

# Skip header
awk -F, 'NR>1 {print $1, $3}' data.csv
```

### Tail Log and Filter Errors in Real-Time
```bash
tail -f /var/log/app.log | grep --line-buffered "ERROR"

# With color
tail -f /var/log/app.log | grep --color=always "ERROR"
```

### Compress Old Logs
```bash
# Compress logs older than 7 days
find /var/log -name "*.log" -mtime +7 -exec gzip {} \;
```

### Top 5 Most Common Error Messages
```bash
grep "ERROR" log.txt | awk '{$1=$2=$3=""; print}' | sort | uniq -c | sort -rn | head -5
```

### Backup with Timestamp
```bash
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
tar -czf "backup_${timestamp}.tar.gz" /source/directory
```

---

## 7. Error Handling and Debugging

### Exit Codes
```bash
# Check last command status
command
if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Failed"
fi

# Exit with specific code
exit 0  # Success
exit 1  # General error
exit 2  # Misuse of command
```

### set -e (Exit on Error)
```bash
#!/bin/bash
set -e

# Script will exit immediately if any command fails
mkdir /tmp/test
cd /tmp/test
touch file.txt

# If mkdir fails, cd and touch won't execute
```

### set -u (Treat Unset Variables as Error)
```bash
#!/bin/bash
set -u

# This will cause error if NAME is not set
echo "Hello, $NAME"

# Prevents silent bugs from typos
```

### set -o pipefail (Catch Errors in Pipes)
```bash
#!/bin/bash
set -o pipefail

# Without pipefail, only last command's exit code matters
# With pipefail, any failure in pipe causes failure
cat nonexistent.txt | grep "pattern" | sort

# This will fail even if sort succeeds
```

### set -x (Debug Mode / Trace Execution)
```bash
#!/bin/bash
set -x

# Shows each command before executing
NAME="DevOps"
echo "Hello, $NAME"

# Output:
# + NAME=DevOps
# + echo 'Hello, DevOps'
# Hello, DevOps
```

### Combining All Strict Modes
```bash
#!/bin/bash
set -euo pipefail

# Best practice for production scripts
# - Exit on error
# - Treat unset variables as error
# - Catch pipe failures
```

### trap - Cleanup on Exit
```bash
#!/bin/bash

# Define cleanup function
cleanup() {
    echo "Cleaning up..."
    rm -f /tmp/tempfile
}

# Register cleanup to run on exit
trap cleanup EXIT

# Script continues normally
touch /tmp/tempfile
# ... do work ...

# cleanup() runs automatically when script exits
```

### Error Handling with || Operator
```bash
# Execute right side if left side fails
mkdir /tmp/test || { echo "Failed to create directory"; exit 1; }

# Or with simple message
mkdir /tmp/test || echo "Directory already exists"

# Chain multiple commands
cd /project && make && make install || echo "Build failed"
```

---

## 8. Advanced Patterns

### Arithmetic Operations
```bash
# Using $(( ))
result=$(( 5 + 3 ))
result=$(( num1 * num2 ))

# Increment/Decrement
((counter++))
((counter--))
((counter += 5))

# Using let
let result=5+3
let counter++
```

### Arrays
```bash
# Declare array
packages=("nginx" "curl" "wget")

# Access elements
echo "${packages[0]}"        # First element
echo "${packages[@]}"        # All elements
echo "${#packages[@]}"       # Array length

# Loop through array
for pkg in "${packages[@]}"; do
    echo "$pkg"
done
```

### Command Substitution
```bash
# Capture command output
current_date=$(date '+%Y-%m-%d')
hostname=$(hostname)
files=$(ls *.txt)

# Use in strings
echo "Today is $current_date"
```

### Here Documents
```bash
# Multi-line input
cat << EOF > config.txt
server {
    listen 80;
    server_name example.com;
}
EOF

# With variable expansion
cat << EOF
Hello, $NAME
Today is $(date)
EOF
```

### Redirections
```bash
command > file.txt           # Redirect stdout to file (overwrite)
command >> file.txt          # Redirect stdout to file (append)
command 2> error.log         # Redirect stderr to file
command &> all.log           # Redirect both stdout and stderr
command > /dev/null 2>&1     # Discard all output
```

---

## 9. Real-World Script Template

```bash
#!/bin/bash

# Strict mode
set -euo pipefail

# Script metadata
readonly SCRIPT_NAME=$(basename "$0")
readonly SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# Cleanup function
cleanup() {
    # Add cleanup tasks here
    echo "Cleaning up..."
}

# Register cleanup
trap cleanup EXIT

# Usage function
usage() {
    cat << EOF
Usage: $SCRIPT_NAME [OPTIONS] <argument>

Description of what this script does.

OPTIONS:
    -h, --help      Show this help message
    -v, --verbose   Enable verbose output

EXAMPLES:
    $SCRIPT_NAME file.txt
    $SCRIPT_NAME -v file.txt
EOF
    exit 1
}

# Main function
main() {
    # Validate arguments
    if [ $# -eq 0 ]; then
        usage
    fi
    
    # Your logic here
    echo "Processing..."
}

# Run main function
main "$@"
```

---

## 10. Cron Syntax Quick Reference

```
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7, 0 and 7 are Sunday)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

### Common Cron Examples
```bash
# Every day at 2 AM
0 2 * * * /path/to/script.sh

# Every Sunday at 3 AM
0 3 * * 0 /path/to/backup.sh

# Every 5 minutes
*/5 * * * * /path/to/check.sh

# Every hour
0 * * * * /path/to/hourly.sh

# First day of every month at midnight
0 0 1 * * /path/to/monthly.sh

# Weekdays at 9 AM
0 9 * * 1-5 /path/to/workday.sh
```

---

## Key Takeaways

1. **Always use strict mode** (`set -euo pipefail`) in production scripts
2. **Validate inputs** before processing (check arguments, file existence)
3. **Use functions** to make code reusable and maintainable
4. **Use local variables** in functions to avoid namespace pollution
5. **Handle errors explicitly** with exit codes and error messages
6. **Quote variables** to prevent word splitting: `"$VAR"` not `$VAR`
7. **Test file operations** before executing (use `-f`, `-d`, `-e`)
8. **Log important operations** with timestamps for debugging
9. **Use meaningful variable names** for readability
10. **Comment complex logic** to help future you

---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`


# Shell-Scripts

A hands-on collection of Bash scripts built during a **#90DaysOfDevOps** journey. Each day covers a new concept — from basic scripting to real-world automation tasks.

---

## Project Structure

```
shell-scripts/
├── day-1/   → Bash basics: variables, input, conditionals
├── day-2/   → Loops, arguments, error handling, package management
├── day-3/   → Functions, local variables, strict mode, system info
├── day-4/   → Backup automation with rotation
└── day-5/   → Log generation and analysis
```

---

## Day 1 — Bash Basics

> Variables, user input, conditionals, and file/service checks.

| Script | Description |
|--------|-------------|
| `hello.sh` | Prints "Hello, DevOps!" — the classic first script |
| `variables.sh` | Declares and uses `NAME` and `ROLE` variables |
| `greet.sh` | Takes user input for name and favourite tool, then greets them |
| `check_number.sh` | Reads a number and checks if it's positive, negative, or zero |
| `file_check.sh` | Reads a filename from input and checks if it exists using `-f` |
| `server_check.sh` | Asks user if they want to check nginx status, then uses `systemctl` |

---

## Day 2 — Loops, Arguments & Error Handling

> For/while loops, command-line arguments, safe scripting, and package management.

| Script | Description |
|--------|-------------|
| `for_loop.sh` | Loops through a list of 5 fruits and prints each one |
| `count.sh` | Prints numbers 1 to 10 using a `for` loop with `{1..10}` range |
| `countdown.sh` | Takes a number from user, counts down to 0 using a `while` loop |
| `greet.sh` | Accepts a name as a CLI argument (`$1`), validates with `-z` flag |
| `args_demo.sh` | Demonstrates `$0`, `$#`, and `$@` — script name, arg count, all args |
| `install_packages.sh` | Checks if nginx/curl/wget are installed (requires root), installs if missing |
| `safe_script.sh` | Uses `set -e` with `||` error handling to safely create dirs and files |

---

## Day 3 — Functions, Scope & Strict Mode

> Reusable functions, local variable scoping, strict mode, and system monitoring.

| Script | Description |
|--------|-------------|
| `function.sh` | Defines `greet()` and `add()` functions using `local` variables |
| `local_demo.sh` | Demonstrates local vs global variable scope inside functions |
| `disk_check.sh` | Two functions: `check_disk()` and `check_memory()` for system health |
| `strict_demo.sh` | Shows `set -euo pipefail` in action — undefined vars, failed commands, pipe errors |
| `system_info.sh` | Full system report: hostname, OS, uptime, disk, memory, top CPU processes |

---

## Day 4 — Backup Automation with Rotation

> Automated backup creation and 5-day rotation policy.

| Script | Description |
|--------|-------------|
| `maintenance.sh` | Backs up files older than 7 days from a source dir, keeps only the latest 5 backups |

**Usage:**
```bash
chmod +x maintenance.sh
./maintenance.sh <source_dir> <backup_dir>
```

**Example:**
```bash
./maintenance.sh /data /backups
```

**What it does:**
- Finds files older than 7 days using `find -mtime +7`
- Zips them into a timestamped archive (`backup_YYYY-MM-DD-HH-MM-SS.zip`)
- Rotates backups — deletes oldest if more than 5 exist

**Cron example (run every 30 days):**
```cron
0 0 */30 * * /path/to/maintenance.sh /data /backups >> /var/log/maintenance.log 2>&1
```

---

## Day 5 — Log Generation & Analysis

> Generate sample logs and analyze them for errors, criticals, and summaries.

| Script | Description |
|--------|-------------|
| `sample_logs_generator.sh` | Generates a log file with random INFO/DEBUG/ERROR/WARNING/CRITICAL entries |
| `log_analyzer.sh` | Analyzes a log file — counts errors, finds top messages, generates a report |

**Workflow:**
```bash
# Step 1: Generate a sample log
./sample_logs_generator.sh app.log 500

# Step 2: Analyze it
./log_analyzer.sh app.log
```

**`sample_logs_generator.sh`:**
- Takes `<log_file_path>` and `<num_lines>` as arguments
- Randomly picks log levels and error messages
- Outputs timestamped log lines

**`log_analyzer.sh`:**
- Validates file exists before processing
- Counts total lines, ERROR count, CRITICAL entries
- Finds top 5 most frequent error messages using `grep | awk | sort | uniq`
- Generates a dated report file (`log_report_DD-MM-YYYY.txt`)
- Archives the original log file into an `archive/` directory

---

## Concepts Covered

| Concept | Where Used |
|---------|-----------|
| Variables & input | Day 1 |
| Conditionals (`if/elif/else`) | Day 1, 2 |
| Loops (`for`, `while`) | Day 2 |
| CLI arguments (`$1`, `$#`, `$@`) | Day 2 |
| Functions & local scope | Day 3 |
| Strict mode (`set -euo pipefail`) | Day 3, 4 |
| `find`, `grep`, `awk`, `sort`, `uniq` | Day 4, 5 |
| Backup & rotation logic | Day 4 |
| Log parsing & reporting | Day 5 |

---

## Running Any Script

```bash
chmod +x script.sh
./script.sh
```

---

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

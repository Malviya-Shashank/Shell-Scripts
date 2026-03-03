# Day 19 Project - Scheduled Maintenance Script

## Overview
This document summarizes my Day 19 implementation using `maintenance.sh`.

The script performs:
- Backup creation for files older than 7 days from a source directory
- Backup rotation to keep only the latest 5 backup archives

---

## Script Used
File: `maintenance.sh`

```bash
#!/bin/bash
<< readme
this is the script for a 5 day rotation

useage:
./maintenance.sh <source_dir> <backup_dir>
./maintenance.sh /mnt/d/90DaysOfDevOps/2026/day-19/data /mnt/d/90DaysOfDevOps/2026/day-19/backups

Compresses .log files older than 7 days using gzip

readme

function display_usage {
	echo "Usage: ./maintenance.sh <source_dir> <backup_dir>"
}

if [ $# -eq 0 ]; then
	display_usage
	exit 1
fi

source_dir=$1
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
backup_dir=$2

function create_backup {
	echo "Creating backup for files older than 7 days..."
	find "${source_dir}" -type f -mtime +7 -print0 | xargs -0 zip -r "${backup_dir}/backup_${timestamp}.zip" > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "backup generated ${timestamp}"
	fi
}

function perform_backup_rotation {
	backups=($(ls -t ${backup_dir}/backup_*.zip 2> /dev/null))
	echo "backups found: ${#backups[@]}"

	if [ ${#backups[@]} -gt 5 ]; then
		echo "Performing rotation for 5 days"
		backups_to_remove=("${backups[@]:5}")
		for backup in "${backups_to_remove[@]}";
		do
			rm -f ${backup}
		done
	fi

}

create_backup
perform_backup_rotation
```

---

## How to Run

```bash
chmod +x maintenance.sh
./maintenance.sh <source_dir> <backup_dir>
```

Example:

```bash
./maintenance.sh /mnt/d/90DaysOfDevOps/2026/day-19/data /mnt/d/90DaysOfDevOps/2026/day-19/backups
```

---

## Sample Output

```text
Creating backup for files older than 7 days...
backup generated 2026-02-25-01-00-00
backups found: 7
Performing rotation for 5 days
```

---

## Cron Entry
To run maintenance every 30 days:

```cron
0 0 */30 * * /mnt/d/90DaysOfDevOps/2026/day-19/maintenance.sh /mnt/d/90DaysOfDevOps/2026/day-19/data /mnt/d/90DaysOfDevOps/2026/day-19/backups >> /var/log/maintenance.log 2>&1
```

---

## What I Learned
- `find` with `-mtime` helps automate age-based file selection.
- Rotation logic can keep backup storage controlled.
- Cron makes maintenance tasks fully automated.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
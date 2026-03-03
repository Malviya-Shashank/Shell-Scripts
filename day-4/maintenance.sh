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
		#echo "${backups_to_remove[@]}"
		for backup in "${backups_to_remove[@]}";
		do
			rm -f ${backup}
		done
	fi

}



create_backup
perform_backup_rotation
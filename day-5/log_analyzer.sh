#!/bin/bash

# Check if argument provided
if [ $# -eq 0 ]; then
    echo "Usage: ./log_analyser.sh <log_file>"
    exit 1
fi

log_file="$1"

# Check if file exists
if [ ! -f "$log_file" ]; then
    echo "Error: File '$log_file' does not exist."
    exit 1
fi

echo "File '$log_file' exists and is ready for analysis."

report_date=$(date '+%d-%m-%Y')
report_file="log_report_${report_date}.txt"

total_line(){
    wc -l $log_file
}

error_count() {
    grep -c "ERROR" "$log_file"
}

critical_count(){
    echo "--- Last 5 Critical Errors ---"
    grep -n "CRITICAL" "$log_file" | head -n 5 | while IFS=: read -r line content; do
        echo "Line $line: $content"
    done
}

function top_error_message(){
    echo "--- Top 5 Error Messages ---"
    grep "ERROR" $log_file | awk '{$3=""; print}' | sort | uniq -c | sort -rn | head -5
}

function Summary_Report(){
    {
    echo "" 
    echo "--- Summary Report ---"
    echo "" 
   
    echo "Report Date: $report_date"
    echo ""
    echo "$report_file"
    echo ""
    echo "total line in tog file: $toal_line"
    echo "$(error_count)"
    echo ""
    echo "Total number of CRITICAL messages: $(critical_count)"
    echo ""
    echo "Top 5 ERROR messages: $(top_error_message)"
    } > "$report_file"
}

archive_log() {

    local archive_dir="archive"

    if [ ! -d "$archive_dir" ]; then
        mkdir -p "$archive_dir"
        echo "Archive directory created."
    fi

    mv "$log_file" "$archive_dir/"
    echo "Log file moved to $archive_dir/ successfully."
}
    



main() {
    
    Summary_Report
    archive_log
}

main
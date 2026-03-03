#!/bin/bash
# Task 2: Functions with Return Values

function check_disk(){
  df -h | grep "/$"
}

function check_memory(){
  free -h
}

# Main section
echo "=== System Health Check ==="
echo ""
echo "--- Disk Usage (/) ---"
check_disk
echo ""
echo "--- Memory Usage ---"
check_memory
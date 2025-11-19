#!/bin/bash

uptime_info() {
    echo "=== UPTIME ==="
    check_command uptime
    uptime -p
}

top_processes() {
    echo "=== TOP PROCESSES ==="
    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
}

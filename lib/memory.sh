#!/bin/bash

memory_info() {
    echo "=== MEMORY INFO ==="
    check_command free
    free -h | awk '/Mem:/ {printf "RAM Used: %s / %s\n", $3, $2}'
}


#!/bin/bash

disk_info() {
    echo "=== DISK INFO ==="
    check_command df
    df -h --output=source,size,used,avail,pcent,target
}


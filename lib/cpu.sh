#!/bin/bash

cpu_info() {
    echo "=== CPU INFO ==="
    check_command lscpu
    check_command top

    if command -v top >/dev/null 2>&1; then
        top -bn1 | awk '/Cpu/ {printf "CPU usage: %.1f%% (user+sys)\n", $2+$4}'
    else
        awk '/^cpu / {idle=$5; total=0; for(i=2;i<=NF;i++) total+=$i; printf "CPU fallback: total=%d idle=%d\n", total, idle}' /proc/stat
    fi
}


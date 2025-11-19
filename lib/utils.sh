#!/bin/bash

LOG_FILE="$HOME/logs/sysinfo.log"

log() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$timestamp [$level] $message" | tee -a "$LOG_FILE"
}

check_command() {
    if ! command -v "$1" >/dev/null 2>&1; then
        log "ERROR" "Commande manquante : $1"
        exit 1
    fi
}


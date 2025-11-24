#!/bin/bash
# Detect script directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# If running locally (lib in project)
if [ -d "$SCRIPT_DIR/lib" ]; then
    LIB_DIR="$SCRIPT_DIR/lib"
elif [ -d "/usr/local/lib/sysinfo-lib" ]; then
    LIB_DIR="/usr/local/lib/sysinfo-lib"
else
    echo "ERROR: No library directory found"
    exit 1
fi

# Load modules
source "$LIB_DIR/utils.sh"
source "$LIB_DIR/cpu.sh"
source "$LIB_DIR/memory.sh"
source "$LIB_DIR/disk.sh"
source "$LIB_DIR/system.sh"


echo "System Info Tool - v2.0"

show_help() {
    echo "Usage: $0 [OPTION]"
    echo "  --cpu       Affiche les infos CPU"
    echo "  --memory    Affiche les infos mémoire"
    echo "  --disk      Affiche les infos disque"
    echo "  --uptime    Affiche le temps d'uptime"
    echo "  --top       Affiche les 5 processus les plus gourmands en CPU"
    echo "  --all       Tout afficher"
    echo "  --help      Afficher l'aide"
}

# Gestion des arguments
case "$1" in
  --cpu)
    log "INFO" "Option --cpu exécutée"
    cpu_info
    ;;
  --memory)
    log "INFO" "Option --memory exécutée"
    memory_info
    ;;
  --disk)
    log "INFO" "Option --disk exécutée"
    disk_info
    ;;
  --uptime)
    log "INFO" "Option --uptime exécutée"
    uptime_info
    ;;
  --top)
    log "INFO" "Option --top exécutée"
    top_processes
    ;;
  --all)
    log "INFO" "Option --all exécutée"
    cpu_info
    memory_info
    disk_info
    uptime_info
    top_processes
    ;;
  --help)
    log "INFO" "Option --help exécutée"
    show_help
    ;;
  *)
    log "ERROR" "Option inconnue: $1"
    show_help
    ;;
esac


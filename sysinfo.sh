#!/bin/bash

echo "System Info Tool - v2.0"

# Charger les modules
source lib/utils.sh
source lib/cpu.sh
source lib/memory.sh
source lib/disk.sh
source lib/system.sh

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


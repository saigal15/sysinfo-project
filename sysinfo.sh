#!/bin/bash
# sysinfo.sh - rapport système léger, conçu pour être lancé par cron
# Chemin absolu pour éviter les problèmes d'environnement cron
HOME_DIR="/home/Mommsen"            # <-- remplace Mommsen par ton user si différent
LOGFILE="$HOME_DIR/logs/sysinfo.log"

# PATH complet pour cron
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH

# Verrou simple pour éviter exécutions concurrentes (optionnel mais utile)
LOCKFILE="/tmp/sysinfo.lock"
exec 200>"$LOCKFILE"
flock -n 200 || exit 0

# En-tête
echo "========================================" >> "$LOGFILE"
echo "SYSTEM REPORT - $(date +"%Y-%m-%d %H:%M:%S")" >> "$LOGFILE"
echo "========================================" >> "$LOGFILE"

# Uptime
echo "[UPTIME]" >> "$LOGFILE"
uptime -p >> "$LOGFILE"
echo "" >> "$LOGFILE"

# CPU Usage
echo "[CPU USAGE]" >> "$LOGFILE"
# extraire la ligne Cpu(s) et afficher la charge utilisateur+system
top -bn1 | awk '/Cpu/ {print "CPU: " $2 + $4 "% used (user+sys)"}' >> "$LOGFILE" 2>/dev/null
echo "" >> "$LOGFILE"

# RAM Usage
echo "[MEMORY USAGE]" >> "$LOGFILE"
free -h | awk '/Mem:/ {print "Total: "$2", Used: "$3", Free: "$4}' >> "$LOGFILE"
echo "" >> "$LOGFILE"

# Disk Usage
echo "[DISK USAGE]" >> "$LOGFILE"
df -h >> "$LOGFILE"
echo "" >> "$LOGFILE"

# Top 5 Processes by CPU
echo "[TOP 5 PROCESSES]" >> "$LOGFILE"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6 >> "$LOGFILE"
echo "" >> "$LOGFILE"

echo "----------------------------------------" >> "$LOGFILE"
echo "" >> "$LOGFILE"

# libération du verrou (se fait automatiquement à la fin du script)


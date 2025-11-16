# SysInfo Monitoring Script

Ce projet contient un script Bash complet permettant de surveiller en continu l'état d'un système Linux.  
Il génère un rapport contenant :

- Uptime du système  
- Utilisation CPU (user + system)  
- Utilisation de la RAM  
- Utilisation des disques (df -h)  
- Top 5 des processus les plus gourmands  
- Formatage propre et lisible dans un fichier log  
- Rotation automatique des logs  
- Exécution automatique via systemd ou cron

---

## 📌 Fonctionnalités principales

### 🔎 Monitoring système
Le script collecte et écrit dans un fichier log les informations suivantes :

- Date et heure
- Uptime
- CPU usage
- RAM usage
- Disk usage
- Top 5 processes

### ��️ Logs avec rotation automatique
Grâce à `logrotate`, les logs sont compressés et archivés quotidiennement.

### ⚙️ Service Systemd + Timer
Le script peut être exécuté automatiquement toutes les 5 minutes grâce à :

- un **service systemd**
- un **timer systemd**


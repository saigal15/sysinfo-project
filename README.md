# Sysinfo Project - v2.0

Un outil simple mais puissant pour monitorer les ressources système et pratiquer l'automatisation avec Bash.

---

## Objectif

- Pratiquer et renforcer les compétences DevOps : scripting, logging, modularité, gestion des services.
- Créer un projet concret pour le portfolio.
- Préparer les bases pour CI/CD et conteneurisation.

---

## Structure du projet

sysinfo.sh # Script principal, gère les arguments
lib/
├─ utils.sh # Fonctions utilitaires (log, vérification de commandes)
├─ cpu.sh # Fonction cpu_info()
├─ memory.sh # Fonction memory_info()
├─ disk.sh # Fonction disk_info()
logs/
└─ sysinfo.log # Historique des exécutions

yaml
Copier le code

---

##  Fonctionnalités

- **Système modulaire :** chaque composant a sa responsabilité.
- **Arguments disponibles :**
  - `--cpu` : affiche les infos CPU
  - `--memory` : affiche les infos mémoire
  - `--disk` : affiche les infos disque
  - `--all` : affiche tout
  - `--help` : affiche l'aide
- **Logging :** toutes les actions sont enregistrées dans `~/logs/sysinfo.log`
- **Gestion des erreurs :** les options inconnues sont détectées et loggées.

---

## Exemple d'utilisation

```bash
# CPU uniquement
./sysinfo.sh --cpu

# Mémoire uniquement
./sysinfo.sh --memory

# Disque uniquement
./sysinfo.sh --disk

# Tout afficher
./sysinfo.sh --all

# Aide
./sysinfo.sh --help

# Option inconnue
./sysinfo.sh --bad
# => message d'erreur et log
# Installation / Pré-requis
Système Linux (Ubuntu recommandé)

Bash

Accès en écriture au dossier ~/logs

Commandes : top, free, df, lscpu (pour CPU, mémoire et disque)

# Commandes utiles
bash
Copier le code
# Rendre le script et modules exécutables
chmod +x sysinfo.sh
chmod +x lib/*.sh

# Lancer le script
./sysinfo.sh --all

# Vérifier les logs
tail -n 20 ~/logs/sysinfo.log
## Logique interne
sysinfo.sh charge tous les modules (utils.sh, cpu.sh, memory.sh, disk.sh) avec source.

Chaque argument déclenche une fonction spécifique.

Les fonctions enregistrent un log [INFO] ou [ERROR] pour chaque exécution.

Le script peut être facilement étendu avec de nouvelles fonctions ou options.

# Notes de version
v2.0

Modularisation : fonctions CPU, mémoire, disque séparées

Logging avec utils.sh

Gestion des arguments et erreurs

Compatible avec future automatisation / cron / systemd

# Sysinfo - System Info Tool

## Description
Sysinfo est un outil Bash qui collecte et affiche des informations système : CPU, mémoire, disque, uptime et top processes.  
Cette version inclut :
- Modularisation des scripts en plusieurs fichiers
- Logs détaillés et gestion des erreurs
- Tests automatisés avec BATS
- Intégration Docker avec build multi-stage

## Features
✅ Modularisation du script (`cpu.sh`, `memory.sh`, `disk.sh`, `utils.sh`, `system.sh`)  
✅ Gestion avancée des arguments : `--cpu`, `--memory`, `--disk`, `--uptime`, `--top`, `--all`, `--help`  
✅ Logging avec niveaux INFO/ERROR  
✅ Tests unitaires BATS intégrés  
✅ Docker multi-stage build pour une image légère et portable  

## Prérequis
- Linux / macOS / Windows (Docker Desktop recommandé)
- Docker et Docker Compose installés
- Git pour cloner le projet

## Installation et usage local
```bash
# Cloner le repo
git clone https://github.com/mommsen/sysinfo-project.git
cd sysinfo-project

# Exécuter le script directement
bash sysinfo.sh --help
bash sysinfo.sh --all

#Exécution des tests

Tests automatisés avec BATS :

# Installer bats si nécessaire
sudo apt install bats

# Exécuter les tests
bats tests/sysinfo.bats


## Docker
# Build multi-stage

docker build -t sysinfo:latest .


# Run l'image
docker run --rm sysinfo:latest --all

# Tests dans Docker
docker run --rm sysinfo:latest bats tests/sysinfo.bats

# Push sur Docker Hub
docker tag sysinfo mommsen15/sysinfo:v1
docker push mommsen15/sysinfo:v1


# Image disponible ici : Docker Hub

Docker Compose (optionnel)

Si tu veux lancer le container via Docker Compose :

docker-compose up

## Objectif

Ce projet montre mes compétences DevOps :

Scripting Bash modulaires

Gestion des logs et erreurs

Tests unitaires automatisés

Création et optimisation d’images Docker

Préparation à CI/CD et déploiement Kubernetes futur

## Liens utiles

GitHub : https://github.com/mommsen/sysinfo-project

Docker Hub : https://hub.docker.com/r/mommsen15/sysinfo

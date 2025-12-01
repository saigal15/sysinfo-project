#!/bin/bash

# Configuration
IMAGE_NAME="mommsen15/sysinfo"

# Lire la version actuelle (ou la créer si elle n'existe pas)
VERSION_FILE="VERSION"

if [ ! -f "$VERSION_FILE" ]; then
    echo "0.1.0" > $VERSION_FILE
fi

VERSION=$(cat $VERSION_FILE)

# Calcul de la prochaine version (auto patch increment)
IFS='.' read -r major minor patch <<< "$VERSION"
patch=$((patch + 1))
NEW_VERSION="${major}.${minor}.${patch}"

echo "Nouvelle version: $NEW_VERSION"

# Mise à jour du fichier VERSION
echo "$NEW_VERSION" > $VERSION_FILE

# Build de l'image
echo "[*] Build de l'image Docker..."
docker build -t sysinfo:latest .

# Tagging
docker tag sysinfo:latest $IMAGE_NAME:$NEW_VERSION
docker tag sysinfo:latest $IMAGE_NAME:latest

# Push
echo "[*] Push vers Docker Hub..."
docker push $IMAGE_NAME:$NEW_VERSION
docker push $IMAGE_NAME:latest

echo "[OK] Release $NEW_VERSION publiée !"

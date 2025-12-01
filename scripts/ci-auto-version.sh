#!/usr/bin/env bash
set -euo pipefail

# Ce script est conçu pour être exécuté dans GitHub Actions:
# - checkout doit avoir fetch-depth: 0 pour récupérer les tags
# - persist-credentials: true pour pouvoir push

REPO="${GITHUB_REPOSITORY:-mommsen15/sysinfo-project}"   # ex: mommsen15/sysinfo-project
IMAGE_NAME="${DOCKERHUB_USERNAME:-mommsen15}/sysinfo"  # DOCKERHUB_USERNAME fourni par secret

# Get last tag (lexicographically last semantic tag); fallback to 0.1.0
LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "0.1.0")
echo "Last tag: $LAST_TAG"

# List changed files between LAST_TAG and HEAD
CHANGED_FILES=$(git diff --name-only "$LAST_TAG" HEAD || true)
echo "Changed files since $LAST_TAG:"
echo "$CHANGED_FILES"

# Determine bump type: MAJOR if sysinfo.sh changed, MINOR if lib/ changed, else PATCH
BUMP="patch"
if echo "$CHANGED_FILES" | grep -q "^sysinfo.sh"; then
  BUMP="major"
elif echo "$CHANGED_FILES" | grep -q "^lib/"; then
  BUMP="minor"
fi
echo "Determined bump type: $BUMP"

# Parse LAST_TAG
IFS='.' read -r MA MI PA <<< "$LAST_TAG"

case "$BUMP" in
  major)
    MA=$((MA + 1))
    MI=0
    PA=0
    ;;
  minor)
    MI=$((MI + 1))
    PA=0
    ;;
  patch)
    PA=$((PA + 1))
    ;;
esac

NEW_VERSION="${MA}.${MI}.${PA}"
echo "New version: $NEW_VERSION"

# Update VERSION file (optional)
echo "$NEW_VERSION" > VERSION
git add VERSION
git commit -m "ci: bump version to $NEW_VERSION [ci skip]" || echo "No changes to commit"

# Create annotated tag and push it
git tag -a "$NEW_VERSION" -m "Auto-release $NEW_VERSION"
git push origin "$NEW_VERSION"

# Export variable for later steps (Docker tags)
echo "::set-output name=new_version::$NEW_VERSION"

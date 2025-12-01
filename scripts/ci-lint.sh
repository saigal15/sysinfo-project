#!/usr/bin/env bash
set -euo pipefail

# Lint all shell scripts in repo (excluding vendor/ etc if necessary)
echo "🔍 Linting shell scripts with shellcheck..."
# installer shellcheck localement si besoin ; dans CI on utilisera une action qui a shellcheck
shellcheck ./*.sh lib/*.sh || exit 1

echo "✅ Lint OK"

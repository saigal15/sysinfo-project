#!/usr/bin/env bash
set -euo pipefail

echo "🧪 Running BATS tests..."
# On suppose que tests/sysinfo.bats existe et s'appuie sur l'environnement (ex: sysinfo.sh présent)
# Sur CI, on va installer bats-core via package manager (apt) ou via action.
bats tests/sysinfo.bats

echo "✅ Tests OK"

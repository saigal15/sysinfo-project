#!/usr/bin/env bats

# Chemin vers le script dans le conteneur
SYSINFO="/usr/local/bin/sysinfo.sh"

@test "Test option --help" {
  run $SYSINFO --help

  [ "$status" -eq 0 ]
  [[ "$output" =~ "Usage" ]]
}

@test "Test option --cpu" {
  run $SYSINFO --cpu

  [ "$status" -eq 0 ]
  [[ "$output" =~ "CPU" ]]
}

@test "Test option --memory" {
  run $SYSINFO --memory

  [ "$status" -eq 0 ]
  [[ "$output" =~ "RAM" ]]
}

@test "Test option --disk" {
  run $SYSINFO --disk

  [ "$status" -eq 0 ]
  [[ "$output" =~ "Filesystem" ]]
}

#!/usr/bin/env bats

setup() {
  cd "$BATS_TEST_DIRNAME/.."
}

@test "Test option --help" {
  run bash "$BATS_TEST_DIRNAME/../sysinfo.sh" --help

  [ "$status" -eq 0 ]
  [[ "$output" =~ "Usage:" ]]
}

@test "Test option --cpu" {
  run bash "$BATS_TEST_DIRNAME/../sysinfo.sh" --cpu

  [ "$status" -eq 0 ]
  [[ "$output" =~ "CPU usage:" ]]
}

@test "Test option --memory" {
  run bash "$BATS_TEST_DIRNAME/../sysinfo.sh" --memory

  [ "$status" -eq 0 ]
  [[ "$output" =~ "RAM Used:" ]]
}

@test "Test option --disk" {
  run bash "$BATS_TEST_DIRNAME/../sysinfo.sh" --disk

  [ "$status" -eq 0 ]
  [[ "$output" =~ "Filesystem" ]]
}

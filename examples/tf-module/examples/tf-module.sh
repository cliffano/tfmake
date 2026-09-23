#!/usr/bin/env bash
set -o errexit
set -o nounset

printf "\n\n========================================\n"
printf "Validate the example Terraform configuration\n"
terraform init -input=false
terraform validate

printf "\n\n========================================\n"
printf "Apply and verify the message module\n"
terraform apply -input=false -auto-approve

message_original="$(terraform output -raw message_original)"
message_reverse="$(terraform output -raw message_reverse)"
message_uppercase="$(terraform output -raw message_uppercase)"
message_lowercase="$(terraform output -raw message_lowercase)"

expected_original="Hello World"
expected_reverse="dlroW olleH"
expected_uppercase="HELLO WORLD"
expected_lowercase="hello world"

check_output() {
  local label="$1" actual="$2" expected="$3"
  if [ "$actual" != "$expected" ]; then
    printf "FAIL: %s - expected '%s', got '%s'\n" "$label" "$expected" "$actual"
    exit 1
  fi
  printf "OK: %s = '%s'\n" "$label" "$actual"
}

check_output "message_original" "$message_original" "$expected_original"
check_output "message_reverse" "$message_reverse" "$expected_reverse"
check_output "message_uppercase" "$message_uppercase" "$expected_uppercase"
check_output "message_lowercase" "$message_lowercase" "$expected_lowercase"

printf "\n\n========================================\n"
printf "Destroy the local-only module state\n"
terraform destroy -input=false -auto-approve

#!/bin/sh

echo "Testing argument validation in entrypoint.sh..."

# Test 1: No arguments
output=$(./entrypoint.sh 2>&1)
exit_code=$?
if [ $exit_code -eq 1 ] && echo "$output" | grep -q "Error: connection-string is missing"; then
  echo "✅ Test 1 (No arguments) passed"
else
  echo "❌ Test 1 (No arguments) failed. Exit code: $exit_code, Output: $output"
  exit 1
fi

# Test 2: One argument
output=$(./entrypoint.sh "mongodb://localhost" 2>&1)
exit_code=$?
if [ $exit_code -eq 1 ] && echo "$output" | grep -q "Error: output-password is missing"; then
  echo "✅ Test 2 (One argument) passed"
else
  echo "❌ Test 2 (One argument) failed. Exit code: $exit_code, Output: $output"
  exit 1
fi

echo "All tests passed successfully! 🎉"
exit 0

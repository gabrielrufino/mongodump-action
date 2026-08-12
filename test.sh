#!/bin/sh

echo "Testing argument validation in entrypoint.sh..."

# Test 1: No arguments
output=$(ACTION_DIR=/tmp ./entrypoint.sh 2>&1)
exit_code=$?
if [ $exit_code -eq 1 ] && echo "$output" | grep -q "Error: connection-string is missing"; then
  echo "✅ Test 1 (No arguments) passed"
else
  echo "❌ Test 1 (No arguments) failed. Exit code: $exit_code, Output: $output"
  exit 1
fi

# Test 2: One argument
output=$(ACTION_DIR=/tmp ./entrypoint.sh "mongodb://localhost" 2>&1)
exit_code=$?
if [ $exit_code -eq 1 ] && echo "$output" | grep -q "Error: output-password is missing"; then
  echo "✅ Test 2 (One argument) passed"
else
  echo "❌ Test 2 (One argument) failed. Exit code: $exit_code, Output: $output"
  exit 1
fi

# Test 3: mongodump failure
# Create a fake mongodump that fails
mkdir -p /tmp/fake_bin
printf '#!/bin/sh\nexit 1\n' > /tmp/fake_bin/mongodump
chmod +x /tmp/fake_bin/mongodump

# Use the fake mongodump by prepending to PATH and run entrypoint.sh in a subshell
output=$(PATH="/tmp/fake_bin:$PATH" ACTION_DIR=/tmp/fake_bin ./entrypoint.sh "mongodb://localhost" "password" 2>&1)
exit_code=$?

# Clean up
rm -rf /tmp/fake_bin

if [ $exit_code -eq 1 ] && echo "$output" | grep -q "Error: mongodump failed"; then
  echo "✅ Test 3 (mongodump failure) passed"
else
  echo "❌ Test 3 (mongodump failure) failed. Exit code: $exit_code, Output: $output"
  exit 1
fi

echo "All tests passed successfully! 🎉"
exit 0

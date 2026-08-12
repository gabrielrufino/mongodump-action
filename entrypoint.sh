#!/bin/sh -l

if [ -z "$1" ]; then
  echo "Error: connection-string is missing"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Error: output-password is missing"
  exit 1
fi

cd /action || exit 1

if ! mongodump "$1"; then
  echo "Error: mongodump failed"
  exit 1
fi

zip -P "$2" -r dump.zip dump
rm -rf dump

mkdir -p "$GITHUB_WORKSPACE/dump"
cp -r dump.zip "$GITHUB_WORKSPACE/dump"

#!/bin/sh -l

cd /action || exit 1
mongodump "$1"

zip -P "$2" -r dump.zip dump
rm -rf dump

mkdir -p "$GITHUB_WORKSPACE/dump"
cp -r dump.zip "$GITHUB_WORKSPACE/dump"

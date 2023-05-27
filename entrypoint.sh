#!/bin/sh -l

cd /action
echo $1
mongodump $1
cp dump $GITHUB_WORKSPACE

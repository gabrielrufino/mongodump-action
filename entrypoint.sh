#!/bin/sh -l

cd /action
mongodump $1
cp -r dump $GITHUB_WORKSPACE

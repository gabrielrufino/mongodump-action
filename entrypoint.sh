#!/bin/sh -l

cd /action
mongodump $INPUT_CONNECTION_STRING
cp dump $GITHUB_WORKSPACE

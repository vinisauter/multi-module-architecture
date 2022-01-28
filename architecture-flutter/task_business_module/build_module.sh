#!/bin/sh
# define variable
LIBFOLDER="${PWD}/../flutter-libs"

echo "Module will be save in: {$LIBFOLDER}"

flutter build aar --output-dir=${LIBFOLDER}
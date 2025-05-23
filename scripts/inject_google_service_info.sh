#!/bin/bash

set -e

echo "Injecting GoogleService-Info.plist...."

echo "CI_WORKSPACE = $CI_WORKSPACE"

# Check if variable is set
if [ -z "$GOOGLE_SERVICE_INFO_PLIST" ]; then
  echo "GOOGLE_SERVICE_INFO_PLIST is not set!"
  exit 1
fi

# Ensure directory exists
mkdir -p "$CI_WORKSPACE/Downforce"

echo "Before injection:"
ls -l "$CI_WORKSPACE/Downforce"

# Decode and write plist
echo "$GOOGLE_SERVICE_INFO_PLIST" | base64 --decode > "$CI_WORKSPACE/Downforce/GoogleService-Info.plist"

echo "After injection:"
ls -l "$CI_WORKSPACE/Downforce"

echo "GoogleService-Info.plist injected"
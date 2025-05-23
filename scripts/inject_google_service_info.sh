#!/bin/bash

set -e

echo "Injecting GoogleService-Info.plist...."

echo "Current working directory = $PWD"

# Check if variable is set
if [ -z "$GOOGLE_SERVICE_INFO_PLIST" ]; then
  echo "GOOGLE_SERVICE_INFO_PLIST is not set!"
  exit 1
fi

# Ensure directory exists
mkdir -p "$PWD/Downforce"

echo "Before injection:"
ls -l "$PWD/Downforce"

# Decode and write plist
echo "$GOOGLE_SERVICE_INFO_PLIST" | base64 --decode > "$PWD/Downforce/GoogleService-Info.plist"

echo "After injection:"
ls -l "$PWD/Downforce"

echo "GoogleService-Info.plist injected"

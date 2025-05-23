#!/bin/bash

set -e

echo "Injecting GoogleService-Info.plist...."

# Compute the repo root (one level up from ci_scripts)
REPO_ROOT="$(dirname "$PWD")"
TARGET_PATH="$REPO_ROOT/Downforce"

echo "Repo root: $REPO_ROOT"
echo "Target path: $TARGET_PATH"

# Check if variable is set
if [ -z "$GOOGLE_SERVICE_INFO_PLIST" ]; then
  echo "GOOGLE_SERVICE_INFO_PLIST is not set!"
  exit 1
fi

# Make sure the directory exists
mkdir -p "$TARGET_PATH"

# Before injecting
echo "Before injection:"
ls -l "$TARGET_PATH"

# Inject the plist
echo "$GOOGLE_SERVICE_INFO_PLIST" | base64 --decode > "$TARGET_PATH/GoogleService-Info.plist"

# After injecting
echo "After injection:"
ls -l "$TARGET_PATH"

echo "✅ GoogleService-Info.plist injected to $TARGET_PATH"

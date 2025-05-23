#!/bin/bash

set -e

echo "Injecting GoogleService-Info.plist...."

mkdir -p "$CI_WORKSPACE/Downforce"

ls -l "$CI_WORKSPACE/Downforce"

echo "$GOOGLE_SERVICE_INFO_PLIST" | base64 --decode > "$CI_WORKSPACE/Downforce/GoogleService-Info.plist"

ls -l "$CI_WORKSPACE/Downforce"

echo "GoogleService-Info.plist injected"

#!/bin/bash

set -e

echo "Injecting GoogleService-Info.plist...."

echo "$GOOGLE_SERVICE_INFO_PLIST" | base64 --decode > "$CI_WORKSPACE/Downforce/GoogleService-Info.plist"

echo "GoogleService-Info.plist injected"

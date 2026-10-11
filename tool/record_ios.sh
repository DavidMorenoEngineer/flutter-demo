#!/usr/bin/env bash
# Records the scripted demo walkthrough on an iOS simulator — no human input.
#   tool/record_ios.sh <simulator-udid> [out.mov]
# The simulator must already be booted. Run ONE emulator/simulator at a time.
set -euo pipefail
DEVICE="${1:?usage: record_ios.sh <simulator-udid> [out.mov]}"
OUT="${2:-/tmp/ios_raw.mov}"

xcrun simctl io "$DEVICE" recordVideo --codec=h264 --force "$OUT" &
REC=$!
sleep 3
# integration_test/demo_test.dart taps every tab and talks to Kix by itself.
flutter test integration_test/demo_test.dart -d "$DEVICE"
kill -INT "$REC"; wait "$REC" 2>/dev/null || true
echo "Raw recording: $OUT  (next: tool/process_video.sh)"

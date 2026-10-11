#!/usr/bin/env bash
# Records the scripted demo walkthrough on an Android emulator — no human input.
#   tool/record_android.sh [adb-serial] [out.mp4]
# Run ONE emulator at a time. The first build is slow, so a warm-up pass runs
# first and only the second pass is recorded.
set -euo pipefail
DEVICE="${1:-emulator-5554}"
OUT="${2:-/tmp/android_raw.mp4}"

flutter test integration_test/demo_test.dart -d "$DEVICE"          # warm-up (build + install)
adb -s "$DEVICE" shell am kill-all                                   # free memory for the take
adb -s "$DEVICE" shell input keyevent KEYCODE_HOME
adb -s "$DEVICE" shell "screenrecord --time-limit 170 --bit-rate 8000000 /data/local/tmp/raw.mp4" &
sleep 2
flutter test integration_test/demo_test.dart -d "$DEVICE"          # the recorded take
sleep 3; adb -s "$DEVICE" shell pkill -2 screenrecord; sleep 3
adb -s "$DEVICE" pull /data/local/tmp/raw.mp4 "$OUT"
echo "Raw recording: $OUT  (next: tool/process_video.sh)"

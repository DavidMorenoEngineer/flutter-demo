#!/usr/bin/env bash
# Trims a raw screen recording and exports demo.mp4 + demo.gif.
#   tool/process_video.sh <raw-video> <start-seconds> <duration-seconds> <out-dir>
# Pick <start-seconds> at the first frame of the app (the raw footage begins on
# the launcher / springboard).
set -euo pipefail
RAW="${1:?raw video}"; START="${2:?start s}"; DUR="${3:?duration s}"; OUT="${4:?out dir}"
mkdir -p "$OUT"
# Trim with filters (not -ss): simulator/emulator recordings are variable-frame-rate.
ffmpeg -v error -y -i "$RAW" \
  -vf "fps=30,trim=start=$START:duration=$DUR,setpts=PTS-STARTPTS,scale=540:-2" \
  -c:v libx264 -crf 27 -pix_fmt yuv420p -an "$OUT/demo.mp4"
ffmpeg -v error -y -i "$OUT/demo.mp4" \
  -vf "fps=8,scale=240:-1:flags=lanczos,split[a][b];[a]palettegen=max_colors=64[p];[b][p]paletteuse=dither=bayer:bayer_scale=5" \
  "$OUT/demo.gif"
echo "Wrote $OUT/demo.mp4 and $OUT/demo.gif"

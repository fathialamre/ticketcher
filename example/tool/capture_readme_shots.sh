#!/usr/bin/env bash
# Regenerates the README screenshots in ../screenshots/readme/.
#
# Needs a booted iPhone 16 Pro simulator (402 × 874 pt, 3x). Runs
# lib/readme_shots.dart in autoplay mode, grabs each page while it is on
# screen, and crops the 402 × 500 pt frame below the status bar.
#
#   cd example && tool/capture_readme_shots.sh [simulator-udid]
set -euo pipefail

cd "$(dirname "$0")/.."
DEVICE="${1:-booted}"
OUT=../screenshots/readme
TMP=$(mktemp -d)
mkdir -p "$OUT"

# Page order must match the shots list in lib/readme_shots.dart.
NAMES=(
  cover flip stamps rtl expired notch_shapes dividers border_patterns
  gradients gradient_border image_background colored_sections blur watermark stitching stack_effect
  punch_holes boarding_pass
)

# Frame geometry in device pixels: 62 pt safe area, 402 × 500 pt frame, 3x.
TOP=186
WIDTH=1206
HEIGHT=1500

LOG="$TMP/run.log"
flutter run -t lib/readme_shots.dart --dart-define=AUTOPLAY=true \
  -d "$DEVICE" >"$LOG" 2>&1 &
RUN_PID=$!
trap 'kill $RUN_PID 2>/dev/null || true; rm -rf "$TMP"' EXIT

until grep -q "Flutter run key commands" "$LOG"; do
  if ! kill -0 $RUN_PID 2>/dev/null; then cat "$LOG"; exit 1; fi
  sleep 0.5
done

# Poll the screen about once a second. A frame counts as a page once it
# is identical on two polls in a row (this skips the launch screen and
# any frame caught mid-switch); each new stable frame is the next page.
frames=()
prev=""
accepted=""
deadline=$((SECONDS + 6 + 3 * ${#NAMES[@]} + 15))
while ((SECONDS < deadline)) && ((${#frames[@]} < ${#NAMES[@]})); do
  xcrun simctl io "$DEVICE" screenshot "$TMP/raw.png" >/dev/null 2>&1
  sips -c $HEIGHT $WIDTH --cropOffset $TOP 0 "$TMP/raw.png" \
    --out "$TMP/frame.png" >/dev/null
  sum=$(md5 -q "$TMP/frame.png")
  if [[ "$sum" == "$prev" && "$sum" != "$accepted" ]]; then
    i=${#frames[@]}
    cp "$TMP/frame.png" "$TMP/page_$i.png"
    frames+=("$TMP/page_$i.png")
    accepted=$sum
  fi
  prev=$sum
  sleep 0.5
done

if ((${#frames[@]} != ${#NAMES[@]})); then
  echo "expected ${#NAMES[@]} pages, saw ${#frames[@]}" >&2
  exit 1
fi

for i in "${!NAMES[@]}"; do
  # 804 × 1000: crisp at README sizes without bloating the repo.
  sips -Z 1000 "${frames[$i]}" --out "$OUT/${NAMES[$i]}.png" >/dev/null
  echo "captured ${NAMES[$i]}"
done

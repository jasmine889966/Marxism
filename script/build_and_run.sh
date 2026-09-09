#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
export DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode-beta.app/Contents/Developer}"
mode="${1:-run}"
case "$mode" in run|--debug|--logs|--telemetry|--verify|--build-only) ;; *) echo "usage: $0 [--build-only|--debug|--logs|--telemetry|--verify]" >&2; exit 2;; esac
if [[ "$mode" != --build-only ]]; then pkill -x Marxism >/dev/null 2>&1 || true; fi
xcodebuild -quiet -project apple/HakoClient/HakoClient.xcodeproj -scheme HakoMac \
  -configuration Debug -destination 'platform=macOS' -derivedDataPath .build/DerivedData \
  CODE_SIGNING_ALLOWED=NO build
app="$PWD/.build/DerivedData/Build/Products/Debug/Marxism.app"
[[ "$mode" == --build-only ]] && exit 0
# Unsigned builds support local UI development, not a provisioned tunnel.
# Do not start the tunnel from this unsigned development run.
open -n "$app"
case "$mode" in
  --debug) lldb -n Marxism ;;
  --logs|--telemetry) /usr/bin/log stream --info --style compact --predicate 'process == "Marxism"' ;;
  --verify) sleep 2; pgrep -x Marxism >/dev/null ;;
esac

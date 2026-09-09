#!/bin/bash
# Package a previously built arm64 Release app as an unsigned interface preview.
set -euo pipefail
cd "$(dirname "$0")/.."
app="${1:-.build/DerivedData-Release/Build/Products/Release/Marxism.app}"
out=".build/distribution"
stage="$(mktemp -d "${TMPDIR:-/tmp}/marxism-package.XXXXXX")"
trap 'rm -rf "$stage"' EXIT
[[ -d "$app" ]] || { echo "Build HakoMac in Release first." >&2; exit 1; }
[[ "$(lipo -archs "$app/Contents/MacOS/Marxism")" == "arm64" ]] || { echo "Expected an arm64-only app." >&2; exit 1; }
mkdir -p "$out"
ditto "$app" "$stage/Marxism.app"
ln -s /Applications "$stage/Applications"
cp LICENSE NOTICE.md "$stage/"
cat > "$stage/READ-ME.txt" <<'NOTE'
Marxism — Apple Silicon interface preview

Drag Marxism to Applications to install.

This is a preview of the interface, not a working VPN distribution.
It has no Developer ID signature or Apple notarization. The shared profile
container, VPN tunnel and iCloud backup are unavailable in this build.
macOS may block it. Only approve the app in System Settings > Privacy & Security
if you trust its source. Do not disable Gatekeeper.

For a working tunnel, build from source with your own Apple signing team,
provisioning profiles and matching capabilities. Direct distribution also needs
a System Extension adaptation; signing this preview alone is not enough.

This is an independent open-source project and is not affiliated with or endorsed by any government, political party, or organization.
This is a just-for-fun visual theme and carries no political message.
Forked from TokenPLS/Hako-Client. Thanks to TokenPLS and all contributors.
See LICENSE and NOTICE.md for source and artwork licenses.

中文：这是 Apple Silicon 界面预览包，没有分发签名及公证，不能连接 VPN，
共享配置容器和 iCloud 备份不可用。将 Marxism 拖入 Applications 即可安装。
仅在信任来源时于系统设置中允许打开，不要关闭 Gatekeeper。
本项目仅供娱乐，无政治意义，与任何政府、政党或组织无关联，也未获其认可。

https://github.com/jasmine889966/Marxism
NOTE
hdiutil create -volname 'Marxism Preview' -srcfolder "$stage" -ov -format UDZO "$out/Marxism-macOS-arm64-preview.dmg"
(cd "$out" && shasum -a 256 Marxism-macOS-arm64-preview.dmg > SHA256SUMS.txt)

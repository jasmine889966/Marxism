# Marxism

**Rule-based proxy utility · powered by Hako**

[中文说明 →](README.zh-CN.md)

Marxism is a native rule-based proxy client for iPhone, iPad, Mac and Apple TV,
with a Soviet-inspired visual theme, licensed historical artwork and localized
historical slogans. Configuration, routing and tunnel behavior come from Hako-Client.

**This project is a modified derivative of TokenPLS/Hako-Client.**
**Licensed under GPL-3.0.** This is not an official upstream release and is not
affiliated with or endorsed by any government or political organization.

## Native on every screen

![Marxism on macOS — English](docs/screenshots/macos-home-en.png)

| iPhone 17e · iOS Simulator | iPad Pro 13-inch · iPadOS Simulator |
| --- | --- |
| <img src="docs/screenshots/iphone-17e-home-en.png" alt="English iPhone home" width="280"> | <img src="docs/screenshots/ipad-pro-13-home-en.png" alt="English iPad home with sidebar" width="520"> |

| Dark appearance · iPad | Connection state · Mac |
| --- | --- |
| <img src="docs/screenshots/ipad-pro-13-home-dark-en.png" alt="English iPad dark appearance" width="420"> | <img src="docs/screenshots/macos-activity-en.png" alt="English disconnected activity state" width="520"> |

Real application captures, using standard text sizes and English app language.
Development builds honestly show missing capabilities; no successful VPN connection
or traffic is staged. [Screenshot details and more views](docs/screenshots/README.md).
The tvOS target builds, but its runtime was unavailable for screenshots.
See [verification](docs/VERIFICATION.md) for the exact scope and remaining checks.

## What changed

- Shared warm-white/charcoal surfaces, deep red navigation and native controls.
- Marx/Engels/Lenin portrait identity and standard Soviet button symbols, localized home slogan and About quotation.
- New app/extension identity: `io.github.jasmine889966.marxism`.
- A startup guard reports missing iCloud capability instead of crashing in unsigned builds.
- Core/profile/network models, dependency pins, import formats and URL schemes remain upstream-compatible.

The first derivative is based on upstream commit
`b05832246fcac69d13ff16df871a8d53fd394c10`.
Internal Hako module names and compatible technical identifiers are deliberately retained.

## Build from source

Requirements: macOS, a compatible full Xcode with Apple SDKs, XcodeGen, Python 3
and Go. Upstream documents Xcode 26.6 and Go 1.26.6; the local verification
uses Xcode 27 beta and Go 1.27.1. Dependencies remain pinned in `Dependencies.lock.json`.

```sh
git clone https://github.com/jasmine889966/Marxism.git
cd Marxism
git remote add upstream https://github.com/TokenPLS/Hako-Client.git
python3 -m venv .build/python-env
source .build/python-env/bin/activate
python3 -m pip install PyYAML
# Set DEVELOPER_DIR to your full Xcode if necessary.
python3 scripts/bootstrap.py
python3 scripts/configure.py
```

Bootstrap builds and verifies all five kernel SDK slices and materializes the
pinned public Adapter. Choose `HakoClient` (iOS/iPadOS), `HakoMac` or `HakoTV`.

```sh
xcodebuild -project apple/HakoClient/HakoClient.xcodeproj \
  -scheme HakoClient -configuration Debug \
  -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO build
```

For the local Mac UI, use `./script/build_and_run.sh --verify`. The script respects
`DEVELOPER_DIR`, falling back to `/Applications/Xcode-beta.app/Contents/Developer`.
It builds locally without a signing identity; this is not a functional tunnel distribution.

### Your signed build

```sh
python3 scripts/configure.py --bundle-base io.github.YOUR_ACCOUNT.marxism --team YOURTEAMID
```

Enable the matching App Groups, Network Extensions, keychain and iCloud capabilities
for your own team and all extensions. Certificates and provisioning profiles are
not included. Containers are independent of the official upstream app; no private
upstream data is automatically migrated. Original import and backup workflows remain.

## Development and attribution

- [UI/function inventory](docs/UI-INVENTORY.md)
- [Design, artwork and quotation sources](docs/BRANDING.md)
- [Validation and limitations](docs/VERIFICATION.md)
- Upstream client: [TokenPLS/Hako-Client](https://github.com/TokenPLS/Hako-Client)
- Kernel: [TokenPLS/Hako](https://github.com/TokenPLS/Hako)
- Adapter: [TokenPLS/Hako-Adapter](https://github.com/TokenPLS/Hako-Adapter)

Run `python3 scripts/verify_theme.py` and the Swift package tests before submitting
changes. Report derivative UI issues here; do not represent this fork as upstream's app.
Remove credentials, subscription URLs and personal data from reports and screenshots.

## License

[GPL-3.0](LICENSE). Original copyrights and third-party licenses remain with their
sources and resources. New source and licensed historical artwork use the same license.

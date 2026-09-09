# Marxism verification — 2026-09-09

This is a source/UI derivative, not a signed release. Successful compilation does
not establish that a provisioned Network Extension, iCloud account or provider works.
The upstream baseline is `b05832246fcac69d13ff16df871a8d53fd394c10`.

## Environment and builds

- Xcode 27 beta (27A5252f), selected per command using `DEVELOPER_DIR`; Go 1.27.1.
- Pinned upstream kernel and adapter from `Dependencies.lock.json`; all five SDK slices present.
- HakoMac: Debug unsigned build and actual macOS launch verified.
- HakoClient: Debug iOS Simulator build verified; unsigned and ad-hoc variants.
- HakoTV: Debug tvOS Simulator build verified.
- Local build logs are ignored under `.build/verification/`.

Upstream baseline compilation under this Xcode failed in `HakoRoutedViewLink` when a
local capture of `_routeIsPresented` inferred optional state storage. Capturing the
existing `$routeIsPresented` binding repairs compilation without changing routing.

## Automated checks

- HakoClientUI tests exercise ten phase/action cases, cancellation vs shutdown,
  direct recovery, and unknown connection duration.
- HakoClientKit tests cover CloudKit entitlement preflight and unavailable operations.
- `python3 scripts/verify_theme.py`: immutable core/action/navigation/lock/license
  checks, localized brand keys, asset catalogs and artwork notices.
- `git diff --check`.

## Actual UI observations

- macOS: real home, sidebar and configuration-unavailable states; light/dark
  appearance inspected. Portraits, standard hammer/sickle, navigation and About
  content are backed by actual application views.
- iPhone 17e / iPad Pro 13-inch simulators: app launches and renders home; removed
  obsolete top spacing and widened the primary action after observing truncation.
- The latest sidebar includes a brand heading. The larger home slogan and themed
  action/status copy are presentation-only. Status text sizes naturally to avoid clipping.
- These observations are not a claim of an exhaustive interactive screen audit.

## Subscription and node sample

A user-authorized private subscription returned HTTP 200 and parsed as YAML:
101 Hysteria2 nodes and 30 proxy groups. Initial download through the current proxy
path timed out; a direct retry succeeded. The pinned Hako CLI accepted the complete
configuration with its `-t` validator.

Six nodes spread across the subscription were sampled through the same kernel's
proxy delay API against an HTTPS 204 endpoint: four succeeded (979–2106 ms), two
returned errors. This measures sampled proxy connectivity, not all-node reliability.
The test used a temporary localhost controller, disabled TUN and listeners, and did
not change system proxy settings or routes. The test process was stopped afterward.
Subscription URLs, credentials, node names and server addresses are excluded from
this repository. Local private inputs/logs remain ignored under `.build/private/`.

## Unverified / blocked

- Signed macOS/iOS/tvOS Network Extension tunnel installation and end-to-end traffic.
  An unsigned Mac lacks the shared container; the simulator reports that VPN
  configuration cannot be read/saved. No successful tunnel is simulated.
- Subscription import/update through the complete app UI, selected-proxy changes,
  all-node latency, configuration edits, logs/DNS/rules/traffic and backup roundtrips
  with a live provisioned tunnel remain unverified.
- tvOS runtime/focus: platform runtime download failed with Apple's authentication
  error Code 41; compilation is verified, runtime is not.
- Exhaustive VoiceOver, maximum Dynamic Type, reduced motion, iPad rotation and
  every localized editor/dialog require further interactive/device coverage.
- App Store distribution and signed installers are outside this delivery.

The reported CloudKit startup crash was reproduced: an unentitled build initialized
CKContainer. The new preflight prevents container creation and uses the existing
unavailable error path. This narrow crash repair is the only HakoClientKit behavior
exception to the visual-only scope; it does not make backup operations succeed.

## Follow-up UI and English review

The shared empty-state component now uses the theme, wraps titles/descriptions,
and distinguishes missing profiles from disconnected activity. The sidebar uses
consistent line symbols and themed labels; destination raw values and action
bindings are unchanged. Product-facing localized Clash wording was rebranded;
third-party client names and compatibility references remain attributed.

English Mac review traversed Home, Proxy Stations, Routing Principles, Link Activity,
Configuration Archives, Engineering Tools, More Settings/Appearance, and About.
The disconnected/missing-profile states, tool descriptions, historical quote and
normal-size sidebar labels were visually checked at 1040 × 720. The English iPhone
home at 390-point width exposed an over-constrained error message: it now wraps
without shrinking. English iPad home was reviewed in light and dark appearance.
Normal-size screenshots from these runs are published in the screenshot gallery.
No claim of every editor or populated provider state is made.

An exploratory maximum-text-size run exposed a fixed-width action label; that
layout constraint was removed. Further maximum-accessibility-size testing was
excluded at the user's request, and the simulator was restored to standard text.
The gallery uses standard sizes only. Mac minimum-window resizing and full iPad
rotation remain unverified; the observed Mac window stayed at its existing size.

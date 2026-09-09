# Marxism visual identity

Marxism is an unofficial GPL-3.0 derivative of TokenPLS/Hako-Client.

The visual layer uses warm neutral surfaces, deep red navigation, system typography,
compact native controls and a Soviet historical identity. Home and product icons use
same-direction portraits of Marx, Engels and Lenin. The home primary-action button
and sidebar Home symbol use the standard Soviet hammer and sickle, always alongside
localized themed action text. The actual action bindings are unchanged; other functional symbols remain recognizable.

## Artwork and licenses

- Portraits: **Marx + Engels + Lenin .svg**, Eugenio Hansen, OFS, 2015,
  **CC BY-SA 4.0**. Source: https://commons.wikimedia.org/wiki/File:Marx_%2B_Engels_%2B_Lenin_.svg
  The source is preserved in `brand/source/marx-engels-lenin.svg`. Monochrome renderings,
  scaled compositions and app icons incorporating these portraits retain CC BY-SA 4.0.
- Hammer and sickle: the construction-sheet-derived Soviet symbol from
  https://commons.wikimedia.org/wiki/File:Hammer_%26_Sickle.svg, **CC0 1.0**.
  Source geometry is preserved exactly; only monochrome color and scale are adapted.
  It is not claimed as original Marxism artwork.
- `brand/marxism-mark.svg` and `brand/marxism-icon.svg` are generated variants.
  `scripts/generate_brand_assets.py` reproduces PNG, ICNS, Icon Composer, menu-bar,
  SF Symbols, tvOS layers and the native SwiftUI path. Install dependencies from
  `scripts/requirements-artwork.txt`; Cairo is required (Homebrew `cairo` on macOS).
- The SF Symbols registration template derives from upstream technical metadata.
  Original client/core attribution and third-party component logos remain intact.

Full notices are in `brand/source/LICENSE-*.txt` and bundled under Resources/Legal.
These artwork licenses are separate from the GPL-3.0 source-code license. No artist
endorsement is implied.

## Historical copy

- Home and sufficiently tall sidebars: **Workers of all countries, unite!** /
  **全世界无产者，联合起来！** / **全世界無產者，聯合起來！**
  Origin: Marx and Engels, *Manifesto of the Communist Party* (1848).
  Also used in early Soviet publications; this is not described as a Soviet invention.
  Source: https://www.marxists.org/history/ussr/publications/kommunist/april02/mayday.htm
- About: **Communism is Soviet power plus the electrification of the whole country.** /
  **共产主义就是苏维埃政权加全国电气化。** /
  **共產主義就是蘇維埃政權加全國電氣化。** — Lenin, 1920.
  Source: https://www.marxists.org/archive/lenin/works/1920/nov/21.htm

Copy is static, localized through the existing app bundle/locale mechanism, and
never rotates or replaces status/error messages. No additional language picker,
remote slogan service, notification or business page is introduced. Long historical
copy is confined to About. The narrow home layout uses only the primary slogan.
Sidebars hide their decorative footer below 760 points or at accessibility sizes.

Chinese political branding is not used. User-provided subscription names, regional
flags and configuration data are displayed unchanged. The Hako core logo and
third-party acknowledgements are attribution, not Marxism branding.

## Native behavior

Existing appearance/accent selections, pure-black preference, Dynamic Type,
VoiceOver semantics, macOS menus, routed navigation and tvOS focus remain available.
The system/default accent uses Marxism red; explicit user-selected colors retain
upstream meaning. Home's existing controls now scroll with its unified identity
section rather than occupying a separate pinned block.

## Themed operation copy

The sidebar heading uses Marxism and “自由联结 · 共同前行”. The home slogan uses
bold title typography. Connection UI maps actions to “连接共产主义”, “断开联络”,
“取消联络”, “重建联络” and “配置联络线路”; corresponding English and Traditional
Chinese strings are included. These are original product copy, not historical quotations.
A short thematic status accompanies the existing technical status. Error details,
proxy/direct distinctions, counters and durations remain factual. Snapshot values,
serialized action identifiers and configuration contents are unchanged.

## Navigation and empty states

Navigation labels use Proxy Stations, Routing Principles, Link Activity,
Configuration Archives, Engineering Tools and More Settings. The stable destination
identifiers are retained. Shared empty states use red-tinted document or communist
symbols with a small gold star, a descriptive title and a factual next-step message.
Loading states retain progress indicators; errors remain errors. Sidebar labels,
empty-state text and connection errors can wrap for longer English copy.

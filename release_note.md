# Subnetter v1.0.0

The first public release of **Subnetter** — a modern, cross-platform IPv4 subnet calculator built with Flutter.

## What's in this release

### 🧮 CIDR Information
- Octet-by-octet IP input with a **live binary representation** of each octet.
- Subnet mask selector from `/0` to `/32`.
- Calculates network address, broadcast, first/last usable host, netmask, wildcard mask, total addresses, usable hosts, **IP class** (A–E), and **private/public** status.
- One-tap copy of the full CIDR report to the clipboard.

### 🔀 Subnet Calculator
- **Equal-size** mode — splits a network into N subnets of identical prefix length.
- **VLSM** (Variable Length Subnet Mask) mode — distributes subnets proportionally.
- Expandable result cards per subnet showing network, broadcast, usable host range, netmask, wildcard, total addresses, and usable hosts.
- Copy any individual subnet's details to the clipboard.

### ⚙️ Settings
- **Theme**: System / Light / Dark
- **Language**: English / العربية (Arabic, full RTL support)

### 📦 Platforms
- Android (ARM64, ARM32, and universal APK)
- Linux (x86_64 AppImage)

---

## Downloads

| Platform | File |
|----------|------|
| Linux (x86_64) | [Subnetter-x86_64.AppImage](https://github.com/OmarBjjash/subnetter/releases/download/v1.0.0/Subnetter-x86_64.AppImage) |
| Android (ARM64) | [app-arm64-v8a-release.apk](https://github.com/OmarBjjash/subnetter/releases/download/v1.0.0/app-arm64-v8a-release.apk) |
| Android (ARM32) | [app-armeabi-v7a-release.apk](https://github.com/OmarBjjash/subnetter/releases/download/v1.0.0/app-armeabi-v7a-release.apk) |
| Android (universal) | [app-release.apk](https://github.com/OmarBjjash/subnetter/releases/download/v1.0.0/app-release.apk) |

---

## Installation

### Linux (AppImage)
The AppImage runs on virtually any x86_64 Linux distribution — no installation required:

```bash
chmod +x Subnetter-x86_64.AppImage
./Subnetter-x86_64.AppImage
```

### Android
1. Download the APK that matches your device's architecture (or use the universal `app-release.apk`).
   - `app-arm64-v8a-release.apk` → 64-bit ARM devices (most modern phones)
   - `app-armeabi-v7a-release.apk` → 32-bit ARM devices (older phones)
   - `app-release.apk` → universal, works on all supported architectures
2. Enable **Unknown sources** in your device's security settings if prompted.
3. Tap the APK to install.

---

## Full Changelog

- Initial release of Subnetter.
- CIDR information calculator with binary IP display.
- Subnet calculator with Equal-size and VLSM modes.
- Clipboard copy for CIDR reports and individual subnets.
- System / Light / Dark theme support.
- English and Arabic (RTL) localization.

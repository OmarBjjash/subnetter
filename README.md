# Subnetter

A modern, cross-platform **IPv4 subnet calculator** built with Flutter.

Subnetter helps network engineers, students, and sysadmins quickly compute CIDR details and split networks into subnets — with a clean Material 3 UI that adapts to every screen size.

---

## Features

### 🧮 CIDR Information
- Octet-by-octet IP address input with a **live binary representation**.
- Subnet mask picker (`/0` – `/32`).
- Instantly shows:
  - Network & Broadcast addresses
  - First & Last usable host
  - Netmask & Wildcard mask
  - Total addresses & Usable hosts
  - **IP class** (A / B / C / D / E)
  - **Private / Public** address indicator
- One-tap **copy** of the full CIDR report to the clipboard.

### 🔀 Subnet Calculator
Split any network into multiple subnets using two modes:
- **Equal-size** — all subnets share the same prefix length.
- **VLSM** (Variable Length Subnet Mask) — subnets sized proportionally to the requested count.
- Expandable result cards per subnet, each showing network, broadcast, usable range, netmask, wildcard, and host counts.
- Copy any individual subnet's details to the clipboard.

### ⚙️ Settings
- **Theme**: System / Light / Dark
- **Language**: English / العربية (Arabic, with full RTL support)

### 📦 Cross-platform
Runs on **Android, iOS, Linux, macOS, Windows, and the Web** from a single codebase.

---

## Downloads

Grab the latest build from the [Releases](https://github.com/OmarBjjash/subnetter/releases) page.

| Platform | File | Notes |
|----------|------|-------|
| Linux (x86_64) | `Subnetter-x86_64.AppImage` | Works on most x86_64 distros |
| Android (ARM64) | `app-arm64-v8a-release.apk` | For 64-bit ARM devices |
| Android (ARM32) | `app-armeabi-v7a-release.apk` | For 32-bit ARM devices |
| Android (universal) | `app-release.apk` | All architectures in one APK |

### Linux (AppImage)
```bash
chmod +x Subnetter-x86_64.AppImage
./Subnetter-x86_64.AppImage
```

### Android
Sideload the `.apk` of your choice (enable *Unknown sources* in your device settings if needed). The universal `app-release.apk` works on every supported architecture.

---

## Building from source

### Prerequisites
- [Flutter](https://docs.flutter.dev/get-started/install) (SDK `^3.13.2`)
- Platform-specific toolchain (Android Studio / Xcode / Linux dev libs / Visual Studio)

### Steps
```bash
# 1. Clone the repo
git clone https://github.com/OmarBjjash/subnetter.git
cd subnetter

# 2. Get dependencies
flutter pub get

# 3. Run on a connected device / emulator
flutter run

# 4. Build release artifacts
flutter build apk --release          # Android (universal APK)
flutter build apk --release --split-per-abi   # Per-ABI APKs
flutter build linux --release        # Linux
```

To package the Linux build as an AppImage, use [`appimagetool`](https://appimage.github.io/appimagetool/) or [`linuxdeploy`](https://github.com/linuxdeploy/linuxdeploy) on the `build/linux/x64/release/bundle` output.

---

## Tech Stack

- **Flutter / Dart** — UI & logic
- **flutter_bloc** — state management
- **get_it** — dependency injection
- **equatable** — value equality
- **shared_preferences** — persisting settings
- **flutter_localizations / intl** — English + Arabic (RTL)

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

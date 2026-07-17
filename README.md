# ByteMail

Local-first Flutter email client for **Windows** and **Android**.

See [docs/SPEC.md](docs/SPEC.md) for the technical specification and [mockups](mockups) for the visual direction.

## Run

```bash
flutter pub get
flutter run -d windows
# or
flutter run -d android
```

## Current status (v0 shell)

- Flutter project scaffolded for Android + Windows
- Module placeholders matching SPEC architecture (`account`, `auth`, `sync`, `repository`, …)
- Calm Dark jewel-tone UI shell with sample mail (no real sync yet)
- Appearance sheet: theme id, Calm/Compact density, Unified + per-account Focus toggles

## Spec defaults

- Theme: Dark (jewel-tone)
- Density: Calm (Compact available in Appearance)
- Focused/Other: optional per account; Unified has its own setting

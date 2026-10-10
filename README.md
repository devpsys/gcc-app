# GCC

Flutter client for GCC, an industrial equipment-rental and bulk marketplace. The app currently ships the application foundation: theme, localization, navigation, networking, and local preferences. Marketplace features are not connected to a backend yet.

## Prerequisites

- Flutter stable with Dart `3.13.5` or newer (`sdk: ^3.13.5`)
- Android SDK for Android builds
- Xcode for iOS builds
- Chrome for web development

This repository was set up with Flutter 3.47.6 and Dart 3.13.5.

## Installation

```bash
flutter pub get
```

`flutter pub get` also generates `lib/l10n/app_localizations*.dart` from `lib/l10n/app_en.arb`. Do not edit the generated files. Change the ARB file and run `flutter gen-l10n`.

## Environment configuration

Environment values are compile-time `--dart-define` flags. No `.env` file is used, and no production API host is configured in the repo.

| Flag | Default | Purpose |
| --- | --- | --- |
| `APP_ENV` | `development` | `development`, `staging`, or `production` |
| `API_BASE_URL` | empty | API origin. Requests fail until this is set. |

```bash
flutter run --dart-define=APP_ENV=development --dart-define=API_BASE_URL=https://your-api.example
```

Staging and production use the same flags with `APP_ENV=staging` or `APP_ENV=production`. Do not commit tokens, keystores, or signing properties.

HTTP logging is enabled only for debug builds of the development environment. Logs omit authorization headers and sensitive query parameters.

## Run

```bash
flutter run --dart-define=APP_ENV=development
flutter run -d chrome --dart-define=APP_ENV=development
flutter run -d ios --dart-define=APP_ENV=development
```

The Android application id is still the template value `com.example.gcc_app`. Replace it before publishing.

## Tests

```bash
flutter test
```

## Release builds

```bash
flutter build apk --dart-define=APP_ENV=production --dart-define=API_BASE_URL=https://your-api.example
flutter build ios --no-codesign --dart-define=APP_ENV=production --dart-define=API_BASE_URL=https://your-api.example
flutter build web --dart-define=APP_ENV=production --dart-define=API_BASE_URL=https://your-api.example
```

Android release builds still use the debug signing config from the Flutter template. Add a real upload keystore before shipping. iOS signing is not configured here.

Web secure storage encrypts values in the browser. It is not equivalent to the iOS Keychain or Android Keystore.

## Localization

English is the only shipped locale. The product also calls for Pidgin, Yoruba, Igbo, and Hausa. Add an ARB file such as `lib/l10n/app_ha.arb` and regenerate. Do not invent those translations in widget code.

## Further reading

See [ARCHITECTURE.md](ARCHITECTURE.md) for layers, data flow, and how to add a feature. Visual specifications live under `docs/design/`.

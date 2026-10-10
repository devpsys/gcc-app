# Architecture

GCC is a feature-based Clean Architecture Flutter app. The running app is a responsive shell plus one feature, home, which loads and saves the appearance preference.

## Layers

```text
lib/
├── app.dart
├── main.dart
├── l10n/
├── core/
│   ├── config/
│   ├── constants/
│   ├── di/
│   ├── error/
│   ├── extensions/
│   ├── network/
│   ├── router/
│   ├── storage/
│   ├── theme/
│   └── widgets/
└── features/
    └── home/
        ├── data/
        ├── domain/
        └── presentation/
```

- **Domain** holds entities and repository contracts. It does not import Flutter widgets, Dio, Hive, BLoC, or GetIt.
- **Data** implements repositories, maps storage values, and translates storage exceptions into failures.
- **Presentation** holds pages, public widgets, and Cubits. Pages do not perform I/O.

Dependency direction:

```text
presentation → domain
data → domain
```

`lib/core/` is shared infrastructure. Feature code may depend on it. Core does not depend on features. `lib/app.dart` is the composition root and may import both.

## Data flow

Appearance is the only vertical slice:

```text
HomePage → HomeCubit → ThemePreferenceRepository → Hive box
```

There is no use case for this flow. Saving a theme mode has no business rule beyond encoding the enum, so a pass-through use case is not part of the design. Add a use case when an operation gains a rule worth testing on its own.

`HomeCubit` emits `HomeLoading`, `HomeReady`, `HomeSaveFailed`, or `HomeFailure`. The app reads `themeMode` from that state and maps it to Flutter's `ThemeMode` in presentation code.

## State management

`flutter_bloc` Cubits are used for feature state. Register a Cubit with `registerFactory` and create it in `BlocProvider` so the widget tree owns its lifetime. Do not construct a repository inside a widget.

## Dependency injection

`configureDependencies()` in `lib/core/di/injection.dart` registers:

- `AppConfig`
- the Hive preferences box and `SecureCredentialStore`
- the shared `Dio` client
- home data sources, the repository, and `HomeCubit`
- `GoRouter`

## Networking and errors

`createDioClient` sets timeouts, JSON headers, and interceptors:

- missing `API_BASE_URL` rejects the request with `ConfigurationException`
- `AuthInterceptor` attaches a bearer token when `SecureCredentialStore` has one
- `ErrorMappingInterceptor` converts `DioException` into an `AppException`
- debug development builds add `RedactingLogInterceptor`

`toFailure` turns an `AppException` into a `Failure` for Cubits. No feature calls the network yet. Token refresh is not implemented.

## Local persistence

Hive stores the theme mode in the `gcc_preferences` box. Tokens, when a future auth feature writes them, go through `SecureCredentialStore` (`flutter_secure_storage`) on Android, iOS, and web. Domain code never sees Hive or the secure-storage plugin.

## Routing

`GoRouter` is created in `lib/core/router/app_router.dart`. Names live in `RouteNames` and paths in `RoutePaths`. The only feature route is `/` (`home`). Unknown paths render `RouteErrorPage`.

There is no auth redirect. Add one when a real session exists. Web path URLs work with GoRouter. Android and iOS app links need a real host before they are declared.

`AppShell` switches layout from the width breakpoints in the design spec:

| Width | Layout |
| --- | --- |
| below 768 | app bar; bottom bar when there are two or more destinations |
| 768–1023 | menu button and drawer |
| 1024 and wider | labeled navigation rail |

Material's `NavigationBar` requires at least two destinations, so a single-item shell omits the bottom bar.

## Design system

`lib/core/theme/` holds the light palette from the GCC design spec, a dark adaptation, typography, spacing, radii, elevation, and breakpoints. Feature widgets consume `Theme` and `AppSemanticColors`.

Held-funds amber and warning are different roles. Amber means money that cannot be moved.

Inter and JetBrains Mono are the specified typefaces. They are not bundled yet, so text uses the platform font at the spec's sizes. Add the font files under the Flutter `fonts:` section before setting `fontFamily`.

## Localization

Static copy is in `lib/l10n/app_en.arb`. Widgets read `context.l10n`. Only English is generated today.

## Adding a feature

1. Create `lib/features/<name>/domain` with the entity and repository contract.
2. Implement data sources and the repository under `data/`. Map exceptions with `toFailure`.
3. Add a Cubit under `presentation/bloc/` and widgets under `presentation/widgets/`. Keep the page free of custom widget classes.
4. Register the feature in `lib/core/di/`.
5. Add a named route in `app_router.dart` and a shell destination only when the screen is real.
6. Put new copy in the ARB file and new visual values in `lib/core/theme/`.
7. Add tests under `test/features/<name>/`.

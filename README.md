# 💧 Water Balance — Daily Hydration Tracker

A beautiful, feature-rich Flutter app for tracking your daily water intake. Built with Material 3, SQLite, and a polished UI with full **dark theme** support.

---

## Screenshots

| Light Theme | Dark Theme |
|-------------|------------|
| _Home, Stats, Profile, Settings_ | _Fully adapted dark palette_ |

---

## Features

- 🔐 **Auth** — Register & login with secure password hashing (SQLite)
- 💧 **Quick Add** — One-tap buttons for 100 / 200 / 330 / 500 ml
- 📊 **Statistics** — Weekly bar chart, monthly overview, achievements
- 🎯 **Smart Goal** — Personalized daily goal based on weight & activity
- 🔔 **Reminders** — Configurable interval, wake-up & bed time
- 🌙 **Dark / Light / Auto theme** — Instant switching in Settings
- 🐛 **Debug Login** — Bypass auth in debug builds (dev only)
- 🗄️ **SQLite persistence** — All data stored locally via `sqflite`

---

## Tech Stack

| Package | Purpose |
|---------|---------|
| `provider ^6.1.2` | State management |
| `go_router ^14.2.0` | Navigation |
| `google_fonts ^6.2.1` | Inter font family |
| `sqflite + sqflite_common_ffi` | Local database (mobile + desktop) |
| `uuid ^4.4.0` | Unique entry IDs |
| `crypto ^3.0.3` | Password hashing |

---

## Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0 <4.0.0`
- Dart SDK

### Run

```bash
flutter pub get
flutter run
```

### Supported platforms
Windows · macOS · Linux · Android · iOS · Web

---

## Project Structure

```
lib/
├── main.dart                  # App entry, theme wiring
├── models/                    # UserProfile, AppSettings, IntakeEntry
├── pages/                     # login, register, home, stats, profile, settings
├── providers/
│   └── app_provider.dart      # State + themeMode + debugLogin()
├── router/
│   └── app_router.dart        # go_router + bottom nav
├── services/
│   └── database_helper.dart   # SQLite CRUD
├── theme/
│   └── app_theme.dart         # AppColorsData ThemeExtension (light & dark)
└── widgets/                   # WaterProgress, QuickAddButtons, WeeklyChart…
```

---

## Dark Theme

The app uses a custom `ThemeExtension<AppColorsData>` for full Material 3 dark theme support.  
Switch anytime: **Settings → Appearance → Theme** (☀️ / 🌙 / 🖥️).

---

## Debug Login (dev only)

On the Login screen in debug builds, a **🐛 Debug Login** button bypasses authentication and logs in as a dummy "Debug User". This button is hidden in release builds (`kDebugMode = false`).

---

## License

MIT

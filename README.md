# Hacker News Reader — Flutter 🚀

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-000000?style=for-the-badge&logo=flutter&logoColor=white)
![Clean Architecture](https://img.shields.io/badge/Clean%20Architecture-4CAF50?style=for-the-badge)
![Hive](https://img.shields.io/badge/Hive%20NoSQL-FFB300?style=for-the-badge)

A production-ready, highly optimized Hacker News reader application built using **Flutter**, **Riverpod**, and strict **Clean Architecture** principles. 

This project was developed to showcase an enterprise-level approach to mobile app development. It features robust offline caching, sophisticated recursive UI rendering, scalable state management, and a beautiful native feel with fluid animations and dark mode support.

---

## 📸 Screenshots

| Light Mode | Dark Mode | Comments & Nested Replies |
|:---:|:---:|:---:|
| <img src="https://via.placeholder.com/250x500.png?text=Light+Mode+Screen" width="200"/> | <img src="https://via.placeholder.com/250x500.png?text=Dark+Mode+Screen" width="200"/> | <img src="https://via.placeholder.com/250x500.png?text=Comments+Screen" width="200"/> |

---

## ✨ Features

- **Infinite Scrolling**: Seamlessly lazy-loads top, best, new, ask, and show stories.
- **Offline Caching (Hive)**: Intercepts network failures to instantly serve cached JSON responses, allowing users to read stories on the subway.
- **Recursive Nested Comments**: Dynamically traverses and renders infinitely nested comment threads using an elegant collapsible tree UI.
- **Dark Mode Support**: Persists user preferences and dynamically shifts the palette to reduce eye strain.
- **Premium UX**: Features custom Shimmer skeleton loaders, native pull-to-refresh, smooth scroll controllers, and beautiful typography.
- **HTML Parsing**: Safely parses complex `<a>`, `<pre>`, and `<code>` blocks from the HN API into native Flutter widgets.
- **Web Launching**: Opens story links directly via the native OS browser.

---

## 🏛️ Architecture Explanation

This application rigidly adheres to **Clean Architecture** combined with a **Feature-First** folder structure. This ensures the codebase is completely modular, highly testable, and deeply scalable.

### Why Clean Architecture?
In standard MVVM or MVC, UI code often leaks into network requests, making the app brittle and difficult to test. By using Clean Architecture:
1. **Total Isolation**: The Presentation layer knows absolutely nothing about `Dio` or JSON parsing. 
2. **The `Result<T>` Pattern**: The Data layer catches all raw Exceptions and maps them into a functional `Result` (Ok/Err) union. This forces the UI layer to explicitly handle errors using exhaustive `switch` statements, completely eliminating "silent crashes."
3. **Mockability**: Because the UI only communicates with abstract Domain `UseCases` and `Repositories`, we can inject mock repositories for blazing-fast unit testing.

---

## 📂 Folder Structure

```text
lib/
├── core/                   # Global utilities
│   ├── constants/          # App constants (durations, sizing, limits)
│   ├── di/                 # Dependency Injection (Riverpod Providers)
│   ├── errors/             # Failure models and Exception mapping
│   ├── network/            # ApiClient singleton and interceptors
│   ├── theme/              # Light and Dark theme configuration
│   └── utils/              # Result<T> union type and formatters
├── data/                   # The boundary to the outside world
│   ├── datasources/        # HnRemoteDataSource (Dio) & HnLocalDataSource (Hive)
│   ├── models/             # Freezed DTOs mapping raw JSON
│   └── repositories/       # Concrete implementations of Domain contracts
├── domain/                 # Pure Dart business logic (No Flutter/Dio)
│   ├── entities/           # Immutable, pure UI models
│   ├── repositories/       # Abstract interfaces
│   └── usecases/           # Specific user intents (e.g., GetCommentsUseCase)
├── presentation/           # The UI layer
│   ├── features/           # Feature-first modules (stories, comments)
│   │   ├── comments/       # Providers, Screens, and Widgets for Comments
│   │   └── stories/        # Providers, Screens, and Widgets for Stories
│   ├── providers/          # Global UI providers (ThemeNotifier)
│   ├── routing/            # GoRouter configuration
│   └── widgets/            # Reusable components (ErrorWidget, Shimmer)
└── main.dart               # App initialization and Hive setup
```

---

## 🛠️ Tech Stack & Packages

| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | State Management & Dependency Injection |
| `dio` | High-performance HTTP networking |
| `freezed` & `json_serializable` | Code generation for immutable models |
| `hive_flutter` | Blazing-fast NoSQL local database for offline caching |
| `go_router` | Declarative, type-safe navigation |
| `shimmer` | Premium skeleton loading animations |
| `flutter_html` | Rendering HTML payloads in comments |
| `shared_preferences` | Persisting user settings (Dark Mode) |
| `flutter_launcher_icons` | Code generation for native OS App Icons |

---

## 🧠 State Management (Riverpod)

The application utilizes **Riverpod** using the modern `StateNotifier` approach.

1. **Immutability**: States (e.g., `StoriesState`, `CommentsState`) are 100% immutable and updated using `.copyWith()`.
2. **Provider Families**: We use `StateNotifierProvider.family` for the comments. This ensures that every individual Story ID gets its own isolated, cached instance of a comment tree. 
3. **No UI Business Logic**: Widgets simply `ref.watch()` state and display it. To trigger an action, they call `ref.read().notifier.loadMore()`.

---

## 📡 API Details

The app interfaces directly with the official [Hacker News Firebase API](https://github.com/HackerNews/API).
- `GET /v0/topstories.json` -> Returns an array of integers (IDs).
- `GET /v0/item/{id}.json` -> Returns a polymorphic JSON object (can be a Story, Comment, Poll, or Job). 

*Note: The HN API does not natively support pagination of full objects. To achieve this, the app fetches the array of IDs, caches it, and then batches concurrent `Future.wait` requests for items in chunks of 15 to ensure high performance.*

---

## ⚙️ Setup Instructions

To run this project locally, ensure you have the Flutter SDK installed (`>=3.0.0`).

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/hn_reader.git
   cd hn_reader
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Models & Native Assets**
   ```bash
   # Generate Freezed models and JSON serializables
   dart run build_runner build --delete-conflicting-outputs

   # Generate Native App Icons and Splash Screens
   flutter pub run flutter_launcher_icons
   flutter pub run flutter_native_splash:create
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

---

## 🚀 Future Improvements

- **Unit Testing**: Add `mocktail` to write exhaustive unit tests for the domain UseCases and StateNotifiers.
- **Bookmarks**: Implement a local "Saved" feature utilizing Isar or SQLite for relational querying.
- **Isolates**: Move the heavy JSON deserialization to a background thread (Isolate) to ensure perfectly smooth 120hz scrolling on older devices.

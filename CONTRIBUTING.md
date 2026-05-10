# Contributing to Hacker News Reader

First off, thank you for considering contributing to this project! It's people like you that make the open-source community such a fantastic place to learn, inspire, and create.

## 🏗️ Architecture Standard
This project strictly adheres to **Clean Architecture**. Before submitting a Pull Request, please ensure:
1. **Domain Isolation**: Your business logic does not import Flutter SDK UI elements, `Dio`, or `Hive`.
2. **State Management**: All UI state is managed via Riverpod `StateNotifier` or `AsyncNotifier`. No business logic should reside inside a Widget.
3. **Error Handling**: Use the `Result<T>` pattern. Do not throw raw Exceptions across architecture boundaries.

## 🚀 Development Workflow

1. **Fork the repo** and create your branch from `main`.
2. If you've added code that should be tested, **add unit tests** using `mocktail`.
3. If you've changed data models, run the code generator:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. **Format your code**:
   ```bash
   dart format .
   ```
5. **Ensure the linter passes**:
   ```bash
   flutter analyze
   ```
   *Note: We use a strict `analysis_options.yaml`. All warnings must be resolved.*

## 📝 Commit Message Convention

We use [Conventional Commits](https://www.conventionalcommits.org/). Please format your commits like so:
- `feat(auth): add login screen`
- `fix(comments): resolve indentation overflow`
- `docs: update README with API limits`
- `chore: update dependencies`

Thank you for helping make this project internship-showcase quality!

# Flutter Usecase Template - Project Structure Guide

Welcome to the Flutter Usecase Template project structure documentation. This guide will help you understand how the project is organized and how to maintain a consistent structure as the project grows.

## Documentation Index

This project includes the following documentation files:

1. [File Structure Guide](FILE_STRUCTURE.md) - Detailed explanation of the file organization and naming conventions
2. [Architecture Overview](ARCHITECTURE.md) - In-depth explanation of the architectural patterns used in this project

## Quick Start

To get started with this project template:

1. Understand the [file structure](FILE_STRUCTURE.md) to know where to place your code
2. Learn about the [architecture](ARCHITECTURE.md) to understand how components interact
3. Follow the patterns and conventions established in the existing code

## Project Organization Summary

This project follows a feature-based organization with clean architecture principles:

```
lib/
├── api/                  # API client and network utilities
├── apps/                 # Feature modules (auth, profile, etc.)
├── base/                 # Base classes and abstractions
├── configs/              # App configuration and constants
├── extensions/           # Dart extension methods
├── ui/                   # Shared UI components
└── utilities/            # Helper functions and utilities
```

Each feature module (`apps/feature_name/`) follows this structure:

```
feature_name/
├── controllers/          # State management
├── models/               # Data models
├── repo/                 # API repositories
├── usecases/             # Business logic
└── views/                # UI components
```

## Key Architectural Components

- **Repository Pattern**: Abstracts data sources (API, local storage)
- **Usecase Pattern**: Orchestrates calls to multiple repositories (only needed for complex flows)
- **Controller Pattern**: Manages UI state with GetX
- **Resource Pattern**: Handles API response states (loading, success, error)

## Getting Started with Development

1. **Adding a new feature**:
   - Create a new directory under `lib/apps/`
   - Follow the established structure (controllers, models, repo, views)
   - Add usecases directory only if you need to coordinate multiple repositories
   - Register dependencies in `init_di.dart`
   - Add routes in `main.dart`

2. **Modifying an existing feature**:
   - Locate the feature directory under `lib/apps/`
   - Make changes following the established patterns
   - Update tests if necessary
   - For example, the profile feature includes a ChangePasswordPage for password management

3. **Adding shared functionality**:
   - For UI components: Add to `lib/ui/components/`
   - For utilities: Add to `lib/utilities/`
   - For extensions: Add to `lib/extensions/`

## Best Practices Summary

1. **Code Organization**:
   - For simple features: Follow the repository → controller → view flow
   - For complex features: Follow the repository → usecase → controller → view flow
   - Keep business logic in appropriate places:
     - Simple data operations in repositories
     - Complex flows involving multiple repositories in usecases

2. **Dependency Injection**:
   - Register dependencies in `init_di.dart`
   - Use `Get.put` for app-wide dependencies
   - Use `Get.lazyPut` with `fenix: true` for feature-specific dependencies

3. **Testing**:
   - Focus testing on models and usecases
   - Test complex business logic flows

For more detailed information, please refer to the [File Structure Guide](FILE_STRUCTURE.md) and [Architecture Overview](ARCHITECTURE.md) documents.
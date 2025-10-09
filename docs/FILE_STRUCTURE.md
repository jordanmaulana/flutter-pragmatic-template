# Flutter Usecase Template - File Structure Guide

This guide provides a comprehensive overview of the file structure and organization principles used in this Flutter project template. Following these guidelines will help maintain consistency and improve code maintainability across the project.

## Project Overview

This template follows a pragmatic approach to Flutter application development, focusing on:

- Clean architecture principles with a practical implementation
- Feature-based organization (apps)
- Use of the GetX library for state management, dependency injection, and routing
- Separation of concerns through repositories, usecases, controllers, and views

## Directory Structure

```
lib/
├── api/                  # API client and network utilities
├── apps/                 # Feature modules
│   ├── auth/             # Authentication feature
│   │   ├── controllers/  # State management for auth screens
│   │   ├── repo/         # API calls related to auth
│   │   ├── usecases/     # Business logic flows for auth
│   │   └── views/        # UI screens for auth
│   ├── main_nav/         # Main navigation feature
│   └── profile/          # Profile management feature
├── base/                 # Base classes and abstractions
├── configs/              # App configuration and constants
├── extensions/           # Dart extension methods
├── ui/                   # Shared UI components
│   └── components/       # Reusable widgets
└── utilities/            # Helper functions and utilities
```

## Key Components

### 1. API Layer (`/api`)

Contains network-related code:
- `dio_client.dart` - HTTP client configuration using Dio
- `dio_exception_extension.dart` - Error handling extensions

### 2. Feature Modules (`/apps`)

Each feature module follows this structure:

```
feature_name/
├── controllers/          # State management
├── models/               # Data models
├── repo/                 # API repositories
├── usecases/             # Business logic
└── views/                # UI components
    ├── list/             # List-related screens
    ├── detail/           # Detail screens
    ├── add/              # Creation screens
    └── change_password/  # Password management screens
```

#### Repository Pattern

Repositories handle data operations from APIs or local storage:

```dart
// Example repository structure
class ProfileRepo {
  final DioClient dioClient;
  final GetStorage box;
  
  ProfileRepo({required this.dioClient, required this.box});
  
  Future<Resource<Profile>> getProfile() async {
    // Implementation
  }
}
```

#### Usecase Pattern

Usecases encapsulate business logic flows:

```dart
// Example usecase structure
class LoginUsecase {
  final AuthRepo authRepo;
  final ProfileRepo profileRepo;
  final GetStorage box;
  
  LoginUsecase({
    required this.authRepo,
    required this.profileRepo,
    required this.box,
  });
  
  Future<Resource<Profile>> execute(String email, String password) async {
    // Implementation of login flow
  }
}
```

#### Controller Pattern

Controllers manage UI state and connect to usecases:

```dart
// Example controller structure
class LoginController extends BaseController {
  final LoginUsecase loginUsecase = Get.find<LoginUsecase>();
  
  // State variables
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Methods to handle UI events
  Future<void> login() async {
    // Implementation
  }
}
```

#### View Pattern

Views are responsible for UI presentation:

```dart
// Example view structure
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          // UI implementation
        );
      },
    );
  }
}
```

### 3. Base Classes (`/base`)

Contains abstract classes and base implementations:
- `base_controller.dart` - Base controller with common functionality
- `export_controller.dart` - Controller exports
- `export_view.dart` - View exports
- `resource.dart` - Resource wrapper for API responses

### 4. Configuration (`/configs`)

Contains app-wide configuration:
- `colors.dart` - Color definitions
- `constants.dart` - App constants
- `flavors.dart` - Environment configuration
- `route_name.dart` - Route definitions
- `theme_service.dart` - Theme configuration

### 5. UI Components (`/ui/components`)

Reusable UI widgets:
- Buttons, inputs, loading indicators, etc.
- Consistent styling components

### 6. Utilities (`/utilities`)

Helper functions:
- `date_utility.dart` - Date formatting and manipulation
- `file_utility.dart` - File operations
- `url_utility.dart` - URL handling

## Dependency Injection

The project uses GetX for dependency injection. All dependencies are registered in `init_di.dart`:

```dart
void initDi() {
  // Register dependencies
  GetStorage box = Get.put(GetStorage());
  DioClient dioClient = Get.put(DioClient(...));
  
  // Register repositories
  Get.put(AuthRepo(dioClient: dioClient));
  Get.lazyPut(() => ProfileRepo(box: box, dioClient: dioClient), fenix: true);
  
  // Register usecases
  Get.lazyPut(() => LoginUsecase(...), fenix: true);
  
  // Register controllers
  Get.put(ProfileController());
}
```

## Best Practices

1. **Feature Organization**:
   - Keep related code together in feature modules
   - Create new feature modules for distinct functionality

2. **File Naming**:
   - Use snake_case for file names
   - Use descriptive names that indicate purpose

3. **Code Organization**:
   - Follow the repository → usecase → controller → view flow
   - Keep business logic in usecases, not in controllers or views

4. **Testing**:
   - Focus testing on models and usecases
   - Test complex business logic flows

5. **Dependency Injection**:
   - Register dependencies in `init_di.dart`
   - Use `Get.put` for app-wide dependencies
   - Use `Get.lazyPut` with `fenix: true` for feature-specific dependencies

## When to Create New Files

### New Repository

Create a new repository when:
- You need to interact with a new API endpoint
- You need to access a new local storage collection

### New Usecase

Create a new usecase when:
- You need to combine multiple repository calls (this is the primary reason to use usecases)
- You have a complex business logic flow that spans multiple data sources
- You need to reuse a flow in multiple places

Note: If your feature only needs to communicate with a single repository, you can directly connect the controller to the repository without creating a usecase. Usecases are primarily beneficial when orchestrating calls to multiple repositories or when implementing complex business logic flows.

### New Controller

Create a new controller when:
- You need to manage state for a new screen
- You need to handle UI logic for a new feature

### New View

Create a new view when:
- You need a new screen in the app
- You need a reusable UI component

## Example: Adding a New Feature

To add a new feature called "Posts" for managing blog posts:

1. Create the directory structure:
   ```
   lib/apps/posts/
   ├── controllers/
   ├── models/
   ├── repo/
   ├── usecases/
   └── views/
   ```

2. Create the repository:
   ```dart
   // lib/apps/posts/repo/posts_repo.dart
   class PostsRepo {
     final DioClient dioClient;
     
     PostsRepo({required this.dioClient});
     
     Future<Resource<List<Post>>> getPosts() async {
       // Implementation
     }
   }
   ```

3. Create usecases:
   ```dart
   // lib/apps/posts/usecases/get_posts_usecase.dart
   class GetPostsUsecase {
     final PostsRepo postsRepo;
     
     GetPostsUsecase({required this.postsRepo});
     
     Future<Resource<List<Post>>> execute() async {
       return postsRepo.getPosts();
     }
   }
   ```

4. Create controllers:
   ```dart
   // lib/apps/posts/controllers/posts_list_controller.dart
   class PostsListController extends BaseController {
     final GetPostsUsecase getPostsUsecase = Get.find<GetPostsUsecase>();
     
     List<Post> posts = [];
     
     Future<void> loadPosts() async {
       // Implementation
     }
   }
   ```

5. Create views:
   ```dart
   // lib/apps/posts/views/list/posts_list_page.dart
   class PostsListPage extends StatelessWidget {
     const PostsListPage({Key? key}) : super(key: key);
     
     @override
     Widget build(BuildContext context) {
       return GetBuilder<PostsListController>(
         builder: (controller) {
           return Scaffold(
             // UI implementation
           );
         },
       );
     }
   }
   ```

6. Register dependencies in `init_di.dart`:
   ```dart
   void initDi() {
     // Existing code...
     
     // Register posts dependencies
     Get.lazyPut(() => PostsRepo(dioClient: Get.find()), fenix: true);
     Get.lazyPut(() => GetPostsUsecase(postsRepo: Get.find()), fenix: true);
   }
   ```

7. Add routes in `main.dart`:
   ```dart
   GetPage(
     name: RouteName.postsList,
     page: () => const PostsListPage(),
   ),
   ```

By following this guide, you'll maintain a consistent and maintainable code structure throughout your Flutter application.
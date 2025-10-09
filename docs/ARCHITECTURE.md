# Flutter Usecase Template - Architecture Overview

This document provides an in-depth explanation of the architectural patterns used in this Flutter project template. Understanding these patterns will help you maintain clean code and scale your application effectively.

## Architectural Approach

This template follows a pragmatic implementation of clean architecture principles, optimized for Flutter development with GetX. The architecture is designed to be:

- **Maintainable**: Clear separation of concerns
- **Testable**: Business logic isolated in usecases
- **Scalable**: Feature-based organization
- **Pragmatic**: Balanced approach between theoretical purity and practical implementation

## Architecture Layers

![Architecture Diagram](architecture.jpg)

The architecture consists of the following layers:

### 1. Presentation Layer (UI)

**Components**: Views, Controllers

**Responsibility**: 
- Display UI elements
- Handle user interactions
- Manage UI state

**Key Classes**:
- `*Page.dart` - UI screens
- `*Controller.dart` - State management

### 2. Domain Layer (Business Logic)

**Components**: Usecases

**Responsibility**:
- Implement business rules
- Orchestrate data flow
- Handle complex operations

**Key Classes**:
- `*Usecase.dart` - Business logic flows

### 3. Data Layer

**Components**: Repositories, API Clients, Local Storage

**Responsibility**:
- Data retrieval and storage
- API communication
- Data transformation

**Key Classes**:
- `*Repo.dart` - Data access
- `DioClient.dart` - Network client

## Data Flow

The typical data flow in the application follows this pattern:

1. **User Interaction**: User interacts with a View
2. **Controller Action**: Controller processes the interaction
3. **Data Access**:
   - For complex flows: Controller calls a Usecase, which orchestrates calls to multiple Repositories
   - For simple flows: Controller directly calls a Repository
4. **API/Storage Interaction**: Repository communicates with API or local storage
5. **Response Processing**: Data flows back through the layers
6. **UI Update**: Controller updates the UI state

## Key Architectural Patterns

### Repository Pattern

The Repository pattern provides a clean API for data access. It abstracts the data source details (API, database, etc.) from the rest of the application.

**Benefits**:
- Centralizes data access logic
- Simplifies testing through mocking
- Provides a consistent interface

**Implementation**:
```dart
class ProfileRepo {
  final DioClient dioClient;
  final GetStorage box;
  
  ProfileRepo({required this.dioClient, required this.box});
  
  Future<Resource<Profile>> getProfile() async {
    try {
      final response = await dioClient.get('/profile');
      return Resource.success(Profile.fromJson(response.data));
    } catch (e) {
      return Resource.error(e.toString());
    }
  }
  
  Future<void> saveProfile(Profile profile) async {
    await box.write('profile', profile.toJson());
  }
}
```

### Usecase Pattern

The Usecase pattern encapsulates business logic and orchestrates the flow of data between the UI and data layers.

**Benefits**:
- Isolates business logic
- Enables reuse across different UI components
- Simplifies testing of complex flows

**Implementation**:
```dart
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
    // 1. Attempt login
    final loginResult = await authRepo.login(email, password);
    if (loginResult.status == Status.ERROR) {
      return Resource.error(loginResult.message ?? "Login failed");
    }
    
    // 2. Save token
    final token = loginResult.data?.token;
    if (token != null) {
      await box.write('token', token);
    }
    
    // 3. Get user profile
    final profileResult = await profileRepo.getProfile();
    if (profileResult.status == Status.SUCCESS) {
      // 4. Save profile locally
      await profileRepo.saveProfile(profileResult.data!);
    }
    
    return profileResult;
  }
}
```

### Controller Pattern with GetX

The Controller pattern using GetX manages UI state and connects the UI to the domain layer.

**Benefits**:
- Separates UI logic from UI presentation
- Provides reactive state management
- Simplifies dependency injection

**Implementation**:
```dart
class LoginController extends BaseController {
  final LoginUsecase loginUsecase = Get.find<LoginUsecase>();
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  
  Future<void> login() async {
    if (!validateInputs()) return;
    
    isLoading.value = true;
    errorMessage.value = '';
    
    final result = await loginUsecase.execute(
      emailController.text,
      passwordController.text,
    );
    
    isLoading.value = false;
    
    if (result.status == Status.SUCCESS) {
      Get.offAllNamed(RouteName.main);
    } else {
      errorMessage.value = result.message ?? "Login failed";
    }
  }
  
  bool validateInputs() {
    // Input validation logic
    return true;
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
```

## Resource Pattern

The Resource pattern wraps API responses to provide a consistent way to handle success, error, and loading states.

**Implementation**:
```dart
enum Status { LOADING, SUCCESS, ERROR }

class Resource<T> {
  final Status status;
  final T? data;
  final String? message;

  Resource({required this.status, this.data, this.message});

  static Resource<T> loading<T>() {
    return Resource<T>(status: Status.LOADING);
  }

  static Resource<T> success<T>(T data) {
    return Resource<T>(status: Status.SUCCESS, data: data);
  }

  static Resource<T> error<T>(String message) {
    return Resource<T>(status: Status.ERROR, message: message);
  }
}
```

## Dependency Injection with GetX

GetX provides a simple dependency injection system that is used throughout the application.

**Implementation**:
```dart
void initDi() {
  // Core dependencies
  GetStorage box = Get.put(GetStorage());
  DioClient dioClient = Get.put(DioClient(...));
  
  // Repositories
  Get.put(AuthRepo(dioClient: dioClient));
  Get.lazyPut(() => ProfileRepo(box: box, dioClient: dioClient), fenix: true);
  
  // Usecases
  Get.lazyPut(() => LoginUsecase(
    authRepo: Get.find(),
    profileRepo: Get.find(),
    box: box,
  ), fenix: true);
  
  // Controllers
  Get.put(ProfileController());
}
```

## Routing with GetX

GetX provides a navigation system that is used for routing in the application.

**Implementation**:
```dart
GetMaterialApp(
  getPages: [
    GetPage(
      name: RouteName.main,
      page: () {
        return GetBuilder(
          builder: (ProfileController controller) {
            if (controller.profile == null) return const LoginPage();
            return const MainNavPage();
          },
        );
      },
    ),
    GetPage(
      name: RouteName.changePassword,
      page: () => const ChangePasswordPage(),
      binding: BindingsBuilder(() {
        Get.put(ChangePasswordController());
      }),
    ),
    // More routes...
  ],
),
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
    ),
    // More routes...
  ],
)
```

## Best Practices

### 1. Separation of Concerns

- Keep UI logic in controllers
- Keep business logic in usecases
- Keep data access logic in repositories

### 2. Dependency Injection

- Register dependencies in `init_di.dart`
- Use `Get.find()` to retrieve dependencies
- Use `fenix: true` for dependencies that need to survive controller disposal

### 3. Error Handling

- Use the Resource pattern for consistent error handling
- Handle errors at the appropriate level
- Provide meaningful error messages to users

### 4. Testing

- Write unit tests for usecases and repositories
- Mock dependencies for isolated testing
- Focus on testing business logic

### 5. State Management

- Use GetX for reactive state management
- Keep state variables in controllers
- Use `.obs` for reactive variables

## When to Use Each Component

### Repository

Use when:
- You need to access data from an API or local storage
- You need to transform data between formats
- You need to cache data

### Usecase

Use when:
- You need to orchestrate multiple repository calls (this is the primary reason to use usecases)
- You have complex business logic that spans multiple data sources
- You need to reuse logic across multiple controllers

Note: For simpler features that only require interaction with a single repository, you can connect controllers directly to repositories without creating usecases. Usecases should be used when there's a need to coordinate multiple data sources or implement complex business flows.

### Controller

Use when:
- You need to manage UI state
- You need to handle user interactions
- You need to connect the UI to usecases

### View

Use when:
- You need to display UI elements
- You need to capture user input
- You need to show feedback to the user

## Architecture Evolution

This architecture is designed to be flexible and can evolve as your application grows:

1. **Small Applications**: 
   - May not need usecases at all
   - Controllers can directly use repositories for simple data operations
   - Focus on feature delivery with minimal architectural overhead

2. **Medium Applications**: 
   - Use usecases only where multiple repositories need to be coordinated
   - Full architecture with repositories, selective usecases, and controllers
   - Balance between pragmatism and clean architecture

3. **Large Applications**: 
   - More extensive use of usecases for complex business logic
   - May add additional layers like services or managers for cross-cutting concerns
   - Focus on maintainability and testability

## Conclusion

This architecture provides a pragmatic approach to building Flutter applications. It balances theoretical purity with practical implementation, allowing for clean, maintainable, and testable code while remaining productive.

By following these architectural patterns, you can build applications that are easy to understand, maintain, and extend over time.
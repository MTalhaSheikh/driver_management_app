# MVC Architecture with GetX

This project follows the **Model-View-Controller (MVC)** architecture pattern using **GetX** for state management, routing, and dependency injection.

## Project Structure

```
lib/
├── main.dart                 # App entry point with GetMaterialApp
├── models/                   # Data models (MVC - Model)
│   └── driver_model.dart
├── views/                    # UI screens (MVC - View)
│   ├── home_view.dart
│   └── splash_view.dart
├── controllers/              # Business logic (MVC - Controller)
│   └── home_controller.dart
├── bindings/                 # Dependency injection bindings
│   └── home_binding.dart
├── routes/                   # Navigation routes
│   ├── app_routes.dart
│   └── app_pages.dart
└── core/                     # Core utilities (optional)
```

## Architecture Overview

### Model (models/)
- Contains data structures and business logic related to data
- Example: `DriverModel` - represents driver data with JSON serialization

### View (views/)
- Contains UI widgets and screens
- Views are **stateless** and use `Get.find<Controller>()` to access controllers
- Use `Obx()` widget to reactively update UI when observable values change

### Controller (controllers/)
- Extends `GetxController`
- Contains business logic and state management
- Uses reactive variables (`RxBool`, `RxString`, `RxList`, etc.)
- Controllers are automatically disposed when not needed

### Bindings (bindings/)
- Handles dependency injection
- Extends `Bindings` class
- Registers controllers using `Get.lazyPut()` or `Get.put()`

### Routes (routes/)
- `app_routes.dart`: Defines route name constants
- `app_pages.dart`: Defines route-to-page mappings with bindings

## GetX Features Used

1. **State Management**: Reactive variables (`RxBool`, `RxString`, `RxList`)
2. **Dependency Injection**: Bindings system
3. **Routing**: Named routes with `GetMaterialApp`
4. **Reactive UI**: `Obx()` widget for automatic UI updates

## Key Concepts

### Reactive Variables
```dart
final RxBool isLoading = false.obs;
final RxList<DriverModel> drivers = <DriverModel>[].obs;
```

### Accessing Controllers
```dart
// In View
final HomeController controller = Get.find<HomeController>();
```

### Reactive UI Updates
```dart
Obx(() {
  return Text('${controller.drivers.length}');
})
```

### Navigation
```dart
Get.toNamed(AppRoutes.home);
Get.offNamed(AppRoutes.home); // Replace current route
Get.back(); // Go back
```

### Dependency Injection
```dart
// In Binding
Get.lazyPut<HomeController>(() => HomeController());

// In View
final controller = Get.find<HomeController>();
```

## Adding New Features

1. **Create Model**: Add model class in `models/`
2. **Create Controller**: Add controller extending `GetxController` in `controllers/`
3. **Create Binding**: Add binding extending `Bindings` in `bindings/`
4. **Create View**: Add view widget in `views/`
5. **Add Route**: Add route constant in `app_routes.dart` and route mapping in `app_pages.dart`

## Example: Adding a New Screen

1. Create model: `lib/models/user_model.dart`
2. Create controller: `lib/controllers/user_controller.dart`
3. Create binding: `lib/bindings/user_binding.dart`
4. Create view: `lib/views/user_view.dart`
5. Add route:
   ```dart
   // In app_routes.dart
   static const String user = '/user';
   
   // In app_pages.dart
   GetPage(
     name: AppRoutes.user,
     page: () => const UserView(),
     binding: UserBinding(),
   ),
   ```

## Benefits of This Architecture

- **Separation of Concerns**: Clear separation between UI, business logic, and data
- **Testability**: Controllers can be easily unit tested
- **Maintainability**: Easy to locate and modify code
- **Scalability**: Easy to add new features following the same pattern
- **Reactive**: Automatic UI updates when state changes
- **Performance**: GetX provides efficient state management with minimal rebuilds

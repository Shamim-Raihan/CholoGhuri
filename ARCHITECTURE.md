# CholoGhuri Flutter App Architecture

## 📱 Overview
Feature-based Flutter app with **GetX state management**, **ScreenUtil responsiveness**, and **Figma-driven components**.

## 🏗️ Architecture Philosophy
- **Feature folders**: Each screen has its own controller/view structure
- **Widget extraction**: Break complex UI into reusable methods
- **Common components**: Use shared widgets for consistency
- **Figma compliance**: Match designs while maintaining code patterns

## 📂 Project Structure
```
lib/
├── main.dart                    # App entry point with ScreenUtil
├── bindings/                    # Dependency injection
│   └── common_bindings.dart    # Centralized controller bindings
├── components/                  # Shared reusable components
│   ├── common_components.dart   # Common UI widgets (buttons, text, fields, dialogs)
│   ├── dialogs.dart            # Custom dialog implementations
│   └── loading_widget.dart     # Loading animation widget
├── helpers/                    # Utility classes and constants
│   ├── color_helper.dart       # App color constants and theme
│   ├── constants_helper.dart   # App-wide constants
│   └── space_helper.dart       # Responsive spacing utilities
├── routes/                     # Navigation management
│   ├── routes_path.dart        # Route path constants
│   └── routes.dart            # GetX route configurations
├── screens/                    # Feature-based screen organization
│   └── [feature_name]/
│       ├── controller/
│       │   └── [feature]_controller.dart
│       └── view/
│           └── [feature]_screen.dart
└── utils/                      # Additional utilities
```

## 🎨 Design System

### 1. Responsive Design with ScreenUtil
```dart
// Setup in main.dart
ScreenUtil.init(
  designSize: const Size(360, 800),
  minTextAdapt: true,
  splitScreenMode: true,
);

// Usage
width: 160.w,           // Responsive width
height: 48.h,           // Responsive height
fontSize: 16.sp,        // Responsive font size
borderRadius: 12.r,     // Responsive radius
margin: 16.h,           // Responsive margin
```

### 2. Color System
```dart
// File: /lib/helpers/color_helper.dart
class ColorHelper {
  static const Color primary = Color(0xFF26187C);
  static const Color accent = Color(0xFF4CAF50);
  static const Color background = Color(0xFFFFFFFF);
  // Add new colors as needed for Figma compliance
}
```

### 3. Spacing System
```dart
// File: /lib/helpers/space_helper.dart
// Vertical spacing options
SpaceHelper.verticalSpace[3,5,8,10,12,15,20,25,30,40,50,60]

// Horizontal spacing options
SpaceHelper.horizontalSpace[3,5,8,10,12,15,20,24,25,30]

// Usage - replaces SizedBox
SpaceHelper.verticalSpace20    // Instead of SizedBox(height: 20.h)
SpaceHelper.horizontalSpace16  // Instead of SizedBox(width: 16.w)
```

## 🧩 Common Components

### Button Component
```dart
CommonComponents().commonButton(
  text: 'Login',
  onPressed: () => controller.onLoginPressed(),
  color: ColorHelper.primary,
  fontColor: ColorHelper.background,
  isLoading: controller.isLoading,
  icon: Icon(Icons.login),           // Optional
  borderRadius: 24,                  // Customizable
)
```

### Text Component
```dart
CommonComponents().commonText(
  fontSize: 16,
  textData: 'Your text here',
  fontWeight: FontWeight.bold,
  color: ColorHelper.primary,
  maxLine: 2,                        // Optional
  textAlign: TextAlign.center,       // Optional
)
```

### Text Field Component
```dart
CommonComponents().commonTextField(
  controller: emailController,
  labelText: 'Email Address',
  prefixIcon: Icons.email,           // Optional
  suffixIcon: IconButton(...),       // Optional
  isPassword: false,
  keyboardType: TextInputType.email,
  validator: (value) { ... },        // Optional
)
```

### Dialog Component
```dart
CommonComponents().commonDialog(
  context: context,
  title: 'Success',
  message: 'Operation completed successfully',
  buttonText: 'OK',
  onButtonPressed: () => Navigator.pop(context),
  isConfirmationDialog: true,        // Optional for Yes/No dialogs
  cancelButtonText: 'No',           // Optional
)
```

## 🎮 GetX Pattern

### Dependency Injection with CommonBindings
We use a **centralized bindings pattern** for all controller dependencies:

```dart
// File: /lib/bindings/common_bindings.dart
class CommonBindings extends Bindings {
  @override
  void dependencies() {
    // Register all controllers here
    Get.lazyPut<LaunchingController>(() => LaunchingController());
    
    // Add new controllers as you create them:
    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

// Usage in routes.dart
GetPage(
  name: RoutesPath.launching,
  page: () => LaunchingScreen(),
  binding: CommonBindings(),
)
```

**Benefits:**
- **Single source**: All controller dependencies in one place
- **Lazy loading**: Controllers created only when needed  
- **Scalable**: Easy to add new controllers as app grows
- **Clean routes**: No need for individual binding files

### Controller Template
```dart
class FeatureController extends GetxController {
  // Reactive variables
  final RxBool isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  
  // Getters
  bool get isLoading => _isLoading.value;
  
  // Methods
  void performAction() async {
    isLoading.value = true;
    // Business logic
    isLoading.value = false;
  }
  
  // Navigation
  void navigateToScreen() => Get.toNamed(RoutesPath.screenName);
  
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
```

### Screen Template
```dart
class FeatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeatureController());
    
    return Scaffold(
      backgroundColor: ColorHelper.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              _buildHeader(),
              SpaceHelper.verticalSpace20,
              _buildContent(controller),
              SpaceHelper.verticalSpace30,
              _buildActions(controller),
            ],
          ),
        ),
      ),
    );
  }
  
  // Extract widgets into methods
  Widget _buildHeader() => CommonComponents().commonText(
    fontSize: 24,
    textData: 'Screen Title',
    fontWeight: FontWeight.bold,
    color: ColorHelper.primary,
  );
  
  Widget _buildContent(FeatureController controller) {
    return Obx(() => Column(
      children: [
        if (controller.isLoading) loadingWidget(),
        // Your content here
      ],
    ));
  }
}
```

## 🧭 Navigation

### Setup Routes
```dart
// routes_path.dart
class RoutesPath {
  static const initial = '/';
  static const featureScreen = '/feature_screen';
}

// routes.dart
GetPage(name: RoutesPath.featureScreen, page: () => FeatureScreen())
```

### Usage
```dart
Get.toNamed(RoutesPath.screenName);           // Navigate
Get.offNamed(RoutesPath.screenName);          // Replace
Get.offAllNamed(RoutesPath.screenName);       // Clear stack
Get.back();                                   // Go back
```

## 🔄 Reactive UI with Obx
```dart
// Simple reactive text
Obx(() => Text(
  controller.isLoading.value ? 'Loading...' : 'Login',
))

// Reactive button state
Obx(() => CommonComponents().commonButton(
  text: 'Submit',
  onPressed: controller.isFormValid ? () => controller.submit() : null,
  disabled: !controller.isFormValid,
))
```

## 📱 Development Workflow

### 1. Create New Screen
```
lib/screens/[feature_name]/
├── controller/[feature_name]_controller.dart
└── view/[feature_name]_screen.dart
```

### 2. Implementation Steps
1. Create controller following GetX pattern
2. Create screen with widget extraction
3. Add route configuration
4. Use CommonComponents for consistency
5. Apply responsive design with ScreenUtil

### 3. Best Practices
- ✅ Use `CommonComponents` for all UI elements
- ✅ Apply `SpaceHelper` instead of `SizedBox`
- ✅ Extract complex widgets into private methods
- ✅ Use `Obx()` only for reactive widgets
- ✅ Follow GetX controller pattern
- ✅ Add responsive sizing with `.w`, `.h`, `.sp`, `.r`
- ✅ Check `ColorHelper` for existing colors, add new ones if needed

### 4. Figma Implementation Guidelines
When implementing Figma designs:
1. Check existing colors in `ColorHelper`, add new ones if needed
2. Use appropriate `SpaceHelper` values for spacing
3. Update `CommonComponents` if they don't match designs
4. Maintain responsive design principles
5. Follow established patterns while matching visual designs

## 🎯 Usage Template

```
"I need to create a [Screen Name] following the CholoGhuri architecture.
Figma link: [link]

Please:
- Use GetX controller pattern
- Use CommonComponents (update if needed)
- Check ColorHelper and add new colors from Figma
- Use SpaceHelper for spacing
- Follow widget extraction pattern
- Create proper folder structure in lib/screens/"
```

This architecture ensures consistent, maintainable, and Figma-compliant Flutter development with clean code principles and scalable structure.
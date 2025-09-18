# UI Components Guide

This guide provides an overview of the reusable UI components available in the Flutter Usecase Template. These components are designed to maintain consistency across the application and speed up development by providing standardized UI elements.

## Table of Contents

1. [Text Components](#text-components)
2. [Button Components](#button-components)
3. [Input Components](#input-components)
4. [Navigation Components](#navigation-components)
5. [Feedback Components](#feedback-components)
6. [List Components](#list-components)
7. [Style Utilities](#style-utilities)
8. [Miscellaneous Components](#miscellaneous-components)
9. [Color System](#color-system)
10. [Best Practices](#best-practices)

## Text Components

### VText

A standardized text widget that handles null strings, number formatting, and money formatting.

**Location**: `lib/ui/components/texts.dart`

**Features**:
- Consistent text styling across the app
- Handles null strings gracefully
- Supports number and money formatting
- Customizable font size, weight, color, and alignment

**Usage**:

```dart
// Basic usage
VText('Hello World')

// With styling
VText(
  'Hello World',
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: VColor.primary,
)

// Number formatting
VText(
  '1000000',
  number: true,  // Displays as "1,000,000"
)

// Money formatting
VText(
  '1000000',
  money: true,  // Displays as "Rp. 1,000,000"
)
```

## Button Components

### PrimaryButton

The main button style with filled background and white text.

**Location**: `lib/ui/components/buttons.dart`

**Features**:
- Full-width button with standardized height
- Rounded corners
- Primary color background
- White text with semi-bold weight

**Usage**:

```dart
PrimaryButton(
  'Submit',
  onTap: () {
    // Action when button is tapped
  },
)
```

### SecondaryButton

A secondary button style with white background, gradient border, and colored text.

**Location**: `lib/ui/components/buttons.dart`

**Features**:
- Full-width button with standardized height
- Rounded corners
- White background with gradient border
- Primary color text

**Usage**:

```dart
SecondaryButton(
  'Cancel',
  onTap: () {
    // Action when button is tapped
  },
)
```

## Input Components

### VFormInput

A customizable form input field with consistent styling.

**Location**: `lib/ui/components/inputs.dart`

**Features**:
- Customizable label and hint text
- Support for prefix and suffix icons
- Form validation
- Customizable border radius and colors
- Support for password fields (obscureText)

**Usage**:

```dart
VFormInput(
  label: 'Email',
  hint: 'Enter your email',
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  },
)
```

## Navigation Components

### StandardAppbar

A customizable app bar with optional back button and actions.

**Location**: `lib/ui/components/app_bar.dart`

**Features**:
- Optional back button
- Customizable title
- Support for action buttons
- Transparent background by default

**Usage**:

```dart
StandardAppbar(
  title: 'Profile',
  includeBackButton: true,
  actions: [
    IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        // Action when settings button is pressed
      },
    ),
  ],
)
```

### VBackButton

A standardized back button for navigation.

**Location**: `lib/ui/components/back_button.dart`

**Features**:
- Consistent styling
- Uses GetX navigation for back functionality

**Usage**:

```dart
VBackButton()
```

## Feedback Components

### VLoading

A standardized loading indicator.

**Location**: `lib/ui/components/loadings.dart`

**Features**:
- Centered circular progress indicator
- Customizable color

**Usage**:

```dart
VLoading()

// With custom color
VLoading(color: Colors.red)
```

### NextPageLoading

A loading indicator for pagination, shown at the bottom of lists.

**Location**: `lib/ui/components/loadings.dart`

**Features**:
- Linear progress indicator
- Fixed position at the bottom of the container
- Optional progress value for determinate loading

**Usage**:

```dart
NextPageLoading()

// With progress value
NextPageLoading(progress: 0.5)
```

### VToast

Toast notifications for success and error messages.

**Location**: `lib/ui/components/toast.dart`

**Features**:
- Success and error toast styles
- Auto-close after 3 seconds
- Progress bar indicator

**Usage**:

```dart
// Success toast
VToast.success('Profile updated successfully')

// Error toast
VToast.error('Failed to update profile')
```

### VPopup

Dialog popups for various scenarios like loading, errors, and confirmations.

**Location**: `lib/ui/components/popup.dart`

**Features**:
- Loading dialog
- Error dialog with optional callback
- Warning dialog with confirmation

**Usage**:

```dart
// Show loading popup
VPopup.loading()

// Hide popup
VPopup.pop()

// Show error popup
VPopup.error('Failed to connect to server')

// Show warning popup with confirmation
VPopup.proceedWarning(
  title: 'Logout',
  message: 'Are you sure you want to logout?',
  callback: () {
    // Action when confirmed
  },
)
```

### VError

A standardized error message display.

**Location**: `lib/ui/components/placeholders.dart`

**Features**:
- Centered error message
- Consistent padding and styling

**Usage**:

```dart
VError('Failed to load data')
```

### NoData

A placeholder for empty data states.

**Location**: `lib/ui/components/placeholders.dart`

**Features**:
- Centered "No data" message
- Customizable text

**Usage**:

```dart
NoData()

// With custom text
NoData(text: 'No messages found')
```

## List Components

### VList

A standardized list view with built-in loading, error handling, and empty state.

**Location**: `lib/ui/components/lists.dart`

**Features**:
- Pull-to-refresh functionality
- Loading state handling
- Error state handling
- Empty state placeholder
- Customizable item separator

**Usage**:

```dart
VList(
  loading: isLoading,
  errorMsg: errorMessage,
  length: items.length,
  onRefresh: () async {
    // Refresh data
    await fetchData();
  },
  itemBuilder: (context, index) {
    return ListTile(
      title: VText(items[index].title),
    );
  },
)
```

### VPaginatedList

An extension of VList with pagination support.

**Location**: `lib/ui/components/lists.dart`

**Features**:
- All features of VList
- Pagination support with automatic next page loading
- Bottom loading indicator for next page

**Usage**:

```dart
VPaginatedList(
  loading: isLoading,
  page: currentPage,
  errorMsg: errorMessage,
  length: items.length,
  onRefresh: () async {
    // Refresh data
    await fetchData(page: 1);
  },
  onNext: () {
    // Load next page
    if (!isLoading && hasMorePages) {
      fetchData(page: currentPage + 1);
    }
  },
  itemBuilder: (context, index) {
    return ListTile(
      title: VText(items[index].title),
    );
  },
)
```

## Style Utilities

### VStyle

A collection of box decoration styles for consistent container styling.

**Location**: `lib/ui/components/styles.dart`

**Features**:
- Box shadow with rounded corners
- Outline with shadow and rounded corners
- Standalone shadow
- Rounded corners

**Usage**:

```dart
// Container with shadow and rounded corners
Container(
  decoration: VStyle.boxShadow(),
  child: VText('Content with shadow'),
)

// Container with outline, shadow, and rounded corners
Container(
  decoration: VStyle.boxShadowOutline(borderColor: Colors.grey),
  child: VText('Content with outline and shadow'),
)

// Container with rounded corners
Container(
  decoration: VStyle.corner(radius: 8.0, color: Colors.white),
  child: VText('Rounded container'),
)
```

## Miscellaneous Components

### VersionText

A widget that displays the current app version from pubspec.yaml.

**Location**: `lib/ui/components/version_text.dart`

**Features**:
- Automatically retrieves version from package info
- Displays formatted version text

**Usage**:

```dart
VersionText()
```

## Color System

The application uses a standardized color system defined in `lib/configs/colors.dart`.

**Key Colors**:

- `VColor.primary`: Main brand color (#00786f)
- `VColor.accent`: Secondary brand color (#00bba7)
- `VColor.tertiary`: Light brand color (#f0fdfa)
- `VColor.dark`: Dark text color (#240F51)
- `VColor.error`: Error color (#c01c67)
- `VColor.border`: Border color (#E0E0E0)
- `VColor.scaffoldBg`: Background color (#f2f9fc)
- `VColor.fieldFillColor`: Form field background (#f3f3f6)

**Usage**:

```dart
// Using colors
Container(
  color: VColor.primary,
  child: VText('Colored container'),
)

// Changing SVG color
SvgPicture.asset(
  'assets/icons/icon.svg',
  colorFilter: VColor.colorFilter(VColor.primary),
)
```

## Best Practices

1. **Consistency**: Always use the provided components instead of creating new ones with different styles.

2. **Color Usage**: Use the colors defined in `VColor` instead of hardcoding color values.

3. **Text Styling**: Use `VText` for all text in the application to maintain consistent typography.

4. **Form Fields**: Use `VFormInput` for all form fields to ensure consistent form styling.

5. **Lists**: Use `VList` or `VPaginatedList` for all lists to ensure consistent loading, error, and empty states.

6. **Feedback**: Use `VToast` and `VPopup` for user feedback to maintain a consistent user experience.

7. **Extending Components**: When creating new components, extend or compose existing ones rather than starting from scratch.

8. **Documentation**: When adding new components, document them in this guide with usage examples.

## Conclusion

This UI component library provides a solid foundation for building consistent and maintainable Flutter applications. By using these standardized components, you can ensure a cohesive user experience across your application while speeding up development time.
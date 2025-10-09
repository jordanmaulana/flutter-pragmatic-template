# UI Components Usage Examples

This document provides practical examples of how to use the UI components in the Flutter Usecase Template in real-world scenarios.

## Text Components Examples

### Basic Text Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_usecase_template/ui/components/texts.dart';
import 'package:flutter_usecase_template/configs/colors.dart';

class TextExamplePage extends StatelessWidget {
  const TextExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Examples')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Regular text
            const VText('Regular Text'),
            const SizedBox(height: 16),
            
            // Styled text
            VText(
              'Styled Text',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: VColor.primary,
            ),
            const SizedBox(height: 16),
            
            // Number formatting
            const VText(
              '1000000',
              number: true, // Will display as 1,000,000
            ),
            const SizedBox(height: 16),
            
            // Money formatting
            const VText(
              '1000000',
              money: true, // Will display as Rp. 1,000,000
            ),
            const SizedBox(height: 16),
            
            // Multi-line text with alignment
            const VText(
              'This is a longer text that will wrap to multiple lines when it reaches the end of the container.',
              align: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
```

## Button Components Examples

### Login Form with Buttons

```dart
import 'package:flutter/material.dart';
import 'package:flutter_usecase_template/ui/components/buttons.dart';
import 'package:flutter_usecase_template/ui/components/inputs.dart';
import 'package:flutter_usecase_template/ui/components/texts.dart';

class LoginExample extends StatelessWidget {
  LoginExample({Key? key}) : super(key: key);
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VText(
              'Login',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 32),
            
            VFormInput(
              label: 'Email',
              hint: 'Enter your email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            
            VFormInput(
              label: 'Password',
              hint: 'Enter your password',
              controller: passwordController,
              obscure: true,
            ),
            const SizedBox(height: 32),
            
            // Primary button for main action
            PrimaryButton(
              'Login',
              onTap: () {
                // Handle login
              },
            ),
            const SizedBox(height: 16),
            
            // Secondary button for secondary action
            SecondaryButton(
              'Register',
              onTap: () {
                // Navigate to registration
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## Form Input Examples

### Registration Form

```dart
import 'package:flutter/material.dart';
import 'package:flutter_usecase_template/ui/components/app_bar.dart';
import 'package:flutter_usecase_template/ui/components/buttons.dart';
import 'package:flutter_usecase_template/ui/components/inputs.dart';
import 'package:flutter_usecase_template/ui/components/texts.dart';

class RegistrationExample extends StatefulWidget {
  const RegistrationExample({Key? key}) : super(key: key);

  @override
  State<RegistrationExample> createState() => _RegistrationExampleState();
}

class _RegistrationExampleState extends State<RegistrationExample> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppbar(title: 'Registration'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              VFormInput(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 16),
              
              VFormInput(
                label: 'Email',
                hint: 'Enter your email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 16),
              
              VFormInput(
                label: 'Password',
                hint: 'Enter your password',
                controller: passwordController,
                obscure: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 16),
              
              VFormInput(
                label: 'Confirm Password',
                hint: 'Confirm your password',
                controller: confirmPasswordController,
                obscure: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              const SizedBox(height: 32),
              
              PrimaryButton(
                'Register',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle registration
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## List Components Examples

### Product List with Pagination

```dart
import 'package:flutter/material.dart';
import 'package:flutter_usecase_template/ui/components/app_bar.dart';
import 'package:flutter_usecase_template/ui/components/lists.dart';
import 'package:flutter_usecase_template/ui/components/texts.dart';
import 'package:flutter_usecase_template/ui/components/styles.dart';
import 'package:flutter_usecase_template/configs/colors.dart';

class ProductListExample extends StatefulWidget {
  const ProductListExample({Key? key}) : super(key: key);

  @override
  State<ProductListExample> createState() => _ProductListExampleState();
}

class _ProductListExampleState extends State<ProductListExample> {
  bool isLoading = false;
  String errorMsg = '';
  List<Product> products = [];
  int currentPage = 1;
  bool hasMorePages = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts({int page = 1}) async {
    setState(() {
      isLoading = true;
      if (page == 1) {
        products = [];
      }
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data
      final newProducts = List.generate(
        10,
        (index) => Product(
          id: (page - 1) * 10 + index + 1,
          name: 'Product ${(page - 1) * 10 + index + 1}',
          price: ((page - 1) * 10 + index + 1) * 10.0,
          imageUrl: 'https://via.placeholder.com/150',
        ),
      );
      
      setState(() {
        if (page == 1) {
          products = newProducts;
        } else {
          products.addAll(newProducts);
        }
        currentPage = page;
        hasMorePages = page < 3; // Only 3 pages for demo
        isLoading = false;
        errorMsg = '';
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMsg = 'Failed to load products: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppbar(title: 'Products'),
      body: VPaginatedList(
        loading: isLoading,
        page: currentPage,
        errorMsg: errorMsg,
        length: products.length,
        onRefresh: () async {
          await fetchProducts(page: 1);
        },
        onNext: () {
          if (!isLoading && hasMorePages) {
            fetchProducts(page: currentPage + 1);
          }
        },
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: VStyle.boxShadow(),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: VColor.tertiary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Icon(Icons.image, color: VColor.primary),
                ),
              ),
              title: VText(
                product.name,
                fontWeight: FontWeight.bold,
              ),
              subtitle: VText(
                product.price.toString(),
                money: true,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to product detail
              },
            ),
          );
        },
      ),
    );
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}
```

## Feedback Components Examples

### Form with Validation and Feedback

```dart
import 'package:flutter/material.dart';
import 'package:flutter_usecase_template/ui/components/app_bar.dart';
import 'package:flutter_usecase_template/ui/components/buttons.dart';
import 'package:flutter_usecase_template/ui/components/inputs.dart';
import 'package:flutter_usecase_template/ui/components/popup.dart';
import 'package:flutter_usecase_template/ui/components/toast.dart';

class FeedbackExample extends StatefulWidget {
  const FeedbackExample({Key? key}) : super(key: key);

  @override
  State<FeedbackExample> createState() => _FeedbackExampleState();
}

class _FeedbackExampleState extends State<FeedbackExample> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Show loading popup
    VPopup.loading();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Hide loading popup
      VPopup.pop();
      
      // Show success toast
      VToast.success('Message sent successfully!');
      
      // Clear form
      nameController.clear();
      emailController.clear();
      messageController.clear();
      _formKey.currentState!.reset();
    } catch (e) {
      // Hide loading popup
      VPopup.pop();
      
      // Show error popup
      VPopup.error(
        'Failed to send message. Please try again later.',
        callback: () {
          // Optional callback when error popup is dismissed
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppbar(title: 'Contact Us'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              VFormInput(
                label: 'Name',
                hint: 'Enter your name',
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              VFormInput(
                label: 'Email',
                hint: 'Enter your email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              VFormInput(
                label: 'Message',
                hint: 'Enter your message',
                controller: messageController,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              
              PrimaryButton(
                'Submit',
                onTap: submitForm,
              ),
              const SizedBox(height: 16),
              
              SecondaryButton(
                'Cancel',
                onTap: () {
                  // Show confirmation popup
                  VPopup.proceedWarning(
                    title: 'Cancel',
                    message: 'Are you sure you want to cancel? All entered data will be lost.',
                    callback: () {
                      // Clear form and navigate back
                      nameController.clear();
                      emailController.clear();
                      messageController.clear();
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Style Utilities Examples

### Card Layout with Styles

```dart
import 'package:flutter/material.dart';
import 'package:flutter_usecase_template/ui/components/app_bar.dart';
import 'package:flutter_usecase_template/ui/components/styles.dart';
import 'package:flutter_usecase_template/ui/components/texts.dart';
import 'package:flutter_usecase_template/configs/colors.dart';

class StylesExample extends StatelessWidget {
  const StylesExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppbar(title: 'Style Examples'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card with shadow
            Container(
              width: double.infinity,
              decoration: VStyle.boxShadow(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VText(
                    'Card with Shadow',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  const VText(
                    'This card uses VStyle.boxShadow() for consistent shadow styling.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Card with outline and shadow
            Container(
              width: double.infinity,
              decoration: VStyle.boxShadowOutline(
                borderColor: VColor.primary,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VText(
                    'Card with Outline and Shadow',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  const VText(
                    'This card uses VStyle.boxShadowOutline() for consistent outline and shadow styling.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Row of rounded containers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: VStyle.corner(
                    radius: 16.0,
                    color: VColor.primary,
                  ),
                  alignment: Alignment.center,
                  child: const VText(
                    'Primary',
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: VStyle.corner(
                    radius: 16.0,
                    color: VColor.accent,
                  ),
                  alignment: Alignment.center,
                  child: const VText(
                    'Accent',
                    color: Colors.white,
                  ),
## Password Management Examples

### Change Password Form

```dart
import 'package:flutter/material.dart';
import 'package:flutter_usecase_template/apps/profile/controllers/change_password_controller.dart';
import 'package:flutter_usecase_template/base/export_view.dart';

class ChangePasswordExample extends StatelessWidget {
  const ChangePasswordExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Map<String, dynamic> data = {};

    ChangePasswordController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VText('Create a strong password to help protect your account.'),
              SizedBox(height: 24.0),
              
              // Current Password Field
              VText(
                'Current Password',
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 4.0),
              Obx(() => VFormInput(
                    prefixIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedSquareLock02,
                      color: VColor.primary,
                    ),
                    obscure: controller.obscurePassword.value,
                    keyboardType: TextInputType.visiblePassword,
                    hint: 'Enter current password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      data["current_password"] = value!;
                    },
                    suffixIcon: IconButton(
                      onPressed: controller.toggleObscurePassword,
                      icon: HugeIcon(
                        icon: controller.obscurePassword.isTrue
                            ? HugeIcons.strokeRoundedView
                            : HugeIcons.strokeRoundedViewOff,
                        color: VColor.primary,
                      ),
                    ),
                  )),
              SizedBox(height: 16.0),
              
              // New Password Field
              VText(
                'New Password',
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 4.0),
              Obx(() => VFormInput(
                    prefixIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedSquareLock02,
                      color: VColor.primary,
                    ),
                    obscure: controller.obscureNewPassword.value,
                    keyboardType: TextInputType.visiblePassword,
                    hint: 'Enter new password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      data["new_password"] = value!;
                    },
                    suffixIcon: IconButton(
                      onPressed: controller.toggleObscureNewPassword,
                      icon: HugeIcon(
                        icon: controller.obscureNewPassword.isTrue
                            ? HugeIcons.strokeRoundedView
                            : HugeIcons.strokeRoundedViewOff,
                        color: VColor.primary,
                      ),
                    ),
                  )),
              SizedBox(height: 16.0),
              
              // Confirm New Password Field
              VText(
                'Confirm New Password',
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 4.0),
              Obx(() => VFormInput(
                    prefixIcon: HugeIcon(
                      icon: HugeIcons.strokeRoundedSquareLock02,
                      color: VColor.primary,
                    ),
                    obscure: controller.obscureNewPasswordConfirmation.value,
                    keyboardType: TextInputType.visiblePassword,
                    hint: 'Confirm new password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      data["new_password_confirmation"] = value!;
                    },
                    suffixIcon: IconButton(
                      onPressed: controller.toggleObscurePasswordConfirmation,
                      icon: HugeIcon(
                        icon: controller.obscureNewPasswordConfirmation.isTrue
                            ? HugeIcons.strokeRoundedView
                            : HugeIcons.strokeRoundedViewOff,
                        color: VColor.primary,
                      ),
                    ),
                  )),
              SizedBox(height: 24.0),
              
              // Update Password Button
              PrimaryButton(
                'Update Password',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    controller.submit(data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## Complete Page Example

### Profile Page with Multiple Components

```dart
import 'package:flutter/material.dart';
import 'package:flutter_usecase_template/ui/components/app_bar.dart';
import 'package:flutter_usecase_template/ui/components/buttons.dart';
import 'package:flutter_usecase_template/ui/components/inputs.dart';
import 'package:flutter_usecase_template/ui/components/loadings.dart';
import 'package:flutter_usecase_template/ui/components/popup.dart';
import 'package:flutter_usecase_template/ui/components/styles.dart';
import 'package:flutter_usecase_template/ui/components/texts.dart';
import 'package:flutter_usecase_template/ui/components/toast.dart';
import 'package:flutter_usecase_template/configs/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: 'John Doe');
  final emailController = TextEditingController(text: 'john.doe@example.com');
  final phoneController = TextEditingController(text: '+1234567890');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppbar(
        title: 'Profile',
        includeBackButton: true,
      ),
      body: isLoading
          ? const VLoading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile header
                  Container(
                    width: double.infinity,
                    decoration: VStyle.boxShadow(),
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Profile avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: VColor.avatarBg,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: VColor.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Profile name
                        const VText(
                          'John Doe',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        
                        // Member since
                        const VText(
                          'Member since: Jan 2023',
                          color: VColor.greyText,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Profile form
                  Container(
                    width: double.infinity,
                    decoration: VStyle.boxShadow(),
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VText(
                            'Personal Information',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 16),
                          
                          VFormInput(
                            label: 'Full Name',
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          VFormInput(
                            label: 'Email',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          VFormInput(
                            label: 'Phone',
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 24),
                          
                          PrimaryButton(
                            'Save Changes',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                
                                // Simulate API call
                                await Future.delayed(const Duration(seconds: 2));
                                
                                setState(() {
                                  isLoading = false;
                                });
                                
                                // Show success toast
                                VToast.success('Profile updated successfully');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Danger zone
                  Container(
                    width: double.infinity,
                    decoration: VStyle.boxShadowOutline(
                      borderColor: VColor.error,
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const VText(
                          'Danger Zone',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: VColor.error,
                        ),
                        const SizedBox(height: 16),
                        
                        SecondaryButton(
                          'Logout',
                          onTap: () {
                            VPopup.proceedWarning(
                              title: 'Logout',
                              message: 'Are you sure you want to logout?',
                              callback: () {
                                // Handle logout
                                VToast.success('Logged out successfully');
                                // Navigate to login page
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        
                        SecondaryButton(
                          'Delete Account',
                          onTap: () {
                            VPopup.proceedWarning(
                              title: 'Delete Account',
                              message: 'Are you sure you want to delete your account? This action cannot be undone.',
                              callback: () {
                                // Handle account deletion
                                VPopup.loading();
                                
                                // Simulate API call
                                Future.delayed(const Duration(seconds: 2), () {
                                  VPopup.pop();
                                  VToast.success('Account deleted successfully');
                                  // Navigate to login page
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
```

## Conclusion

These examples demonstrate how to use the UI components in real-world scenarios. By following these patterns, you can maintain a consistent look and feel across your application while speeding up development time.

Remember to:

1. Import the necessary components from their respective files
2. Use the components according to their intended purpose
3. Combine components to create complex UIs
4. Follow the established styling patterns

For more information on the available components and their properties, refer to the [UI Components Guide](UI_COMPONENTS.md).
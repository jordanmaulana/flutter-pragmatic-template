import 'package:flutter/material.dart';
import 'package:flutter_usecase_template/apps/auth/controllers/forgot_password_controller.dart';
import 'package:flutter_usecase_template/apps/auth/controllers/register_controller.dart';
import 'package:flutter_usecase_template/apps/auth/views/forgot_password_page.dart';
import 'package:flutter_usecase_template/apps/auth/views/login_page.dart';
import 'package:flutter_usecase_template/apps/auth/views/registration_page.dart';
import 'package:flutter_usecase_template/apps/main_nav/views/main_nav_page.dart';
import 'package:flutter_usecase_template/apps/profile/controllers/change_password_controller.dart';
import 'package:flutter_usecase_template/apps/profile/controllers/profile_controller.dart';
import 'package:flutter_usecase_template/apps/profile/views/change_password/change_password_page.dart';
import 'package:flutter_usecase_template/configs/route_name.dart';
import 'package:flutter_usecase_template/init_di.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initDi();
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: false,
          appBarTheme: AppBarTheme(
            titleTextStyle: GoogleFonts.interTight(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
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

          /// Add more pages here
          GetPage(
            name: RouteName.register,
            page: () => const RegistrationPage(),
            binding: BindingsBuilder(() {
              Get.put(RegisterController());
            }),
          ),
          GetPage(
            name: RouteName.forgotPassword,
            page: () => const ForgotPasswordPage(),
            binding: BindingsBuilder(() {
              Get.put(ForgotPasswordController());
            }),
          ),
          GetPage(
            name: RouteName.changePassword,
            page: () => const ChangePasswordPage(),
            binding: BindingsBuilder(() {
              Get.put(ChangePasswordController());
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter_usecase_template/apps/auth/controllers/register_controller.dart';
import 'package:flutter_usecase_template/utilities/url_utility.dart';

import '../../../base/export_view.dart';
import '../../../configs/constants.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Map<String, String> data = {};
    RegisterController controller = Get.find();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [VColor.primary, VColor.accent],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.all(context.lgPadding),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.lgPadding,
                        vertical: context.xlPadding,
                      ),
                      decoration: BoxDecoration(
                        color: VColor.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: VStyle.shadow(),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: context.mdPadding,
                        children: [
                          FlutterLogo(size: 64.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              spacing: context.smPadding,
                              children: [
                                VText(
                                  'Create Account',
                                  color: VColor.primary,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                VText(
                                  'Sign up to get started',
                                  color: VColor.greyText,
                                ),
                              ],
                            ),
                          ),
                          VFormInput(
                            prefixIcon: HugeIcon(
                              icon: HugeIcons.strokeRoundedUser,
                              color: VColor.primary,
                            ),
                            keyboardType: TextInputType.name,
                            hint: 'Enter your full name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              data["full_name"] = value!;
                            },
                          ),
                          VFormInput(
                            prefixIcon: HugeIcon(
                              icon: HugeIcons.strokeRoundedMail01,
                              color: VColor.primary,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            hint: 'Enter your email',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              data["email"] = value!;
                            },
                          ),
                          Obx(() => VFormInput(
                                prefixIcon: HugeIcon(
                                  icon: HugeIcons.strokeRoundedSquareLock02,
                                  color: VColor.primary,
                                ),
                                obscure: controller.obscurePassword.value,
                                keyboardType: TextInputType.visiblePassword,
                                hint: 'Create a password',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password must not be empty';
                                  }
                                  return null;
                                },
                                onSaved: (String? value) {
                                  data["password"] = value!;
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
                          Obx(() => VFormInput(
                                prefixIcon: HugeIcon(
                                  icon: HugeIcons.strokeRoundedSquareLock02,
                                  color: VColor.primary,
                                ),
                                obscure: controller
                                    .obscurePasswordConfirmation.value,
                                keyboardType: TextInputType.visiblePassword,
                                hint: 'Confirm your password',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password must not be empty';
                                  }
                                  return null;
                                },
                                onSaved: (String? value) {
                                  data["password"] = value!;
                                },
                                suffixIcon: IconButton(
                                  onPressed: controller
                                      .toggleObscurePasswordConfirmation,
                                  icon: HugeIcon(
                                    icon: controller
                                            .obscurePasswordConfirmation.isTrue
                                        ? HugeIcons.strokeRoundedView
                                        : HugeIcons.strokeRoundedViewOff,
                                    color: VColor.primary,
                                  ),
                                ),
                              )),
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (value) {},
                                activeColor: VColor.primary,
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'I agree to the ',
                                    style: TextStyle(color: VColor.greyText),
                                    children: [
                                      TextSpan(
                                        text: 'Terms of Service',
                                        style: TextStyle(
                                          color: VColor.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            UrlUtility.openUrl(
                                              Constants.tos,
                                            );
                                          },
                                      ),
                                      TextSpan(
                                        text: ' and ',
                                        style:
                                            TextStyle(color: VColor.greyText),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          color: VColor.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            UrlUtility.openUrl(
                                              Constants.privy,
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          PrimaryButton(
                            'Create Account',
                            onTap: () async {
                              final FormState form = formKey.currentState!;
                              if (!form.validate()) return;
                              form.save();
                              controller.submit();
                            },
                          ),
                          SizedBox(height: context.smPadding),
                          Row(
                            spacing: 4.0,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VText(
                                'Already have an account?',
                                color: VColor.greyText,
                              ),
                              InkWell(
                                onTap: () => Get.back(),
                                child: VText(
                                  'Sign In',
                                  color: VColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

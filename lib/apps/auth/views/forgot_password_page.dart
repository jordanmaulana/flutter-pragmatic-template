import 'package:flutter_usecase_template/apps/auth/controllers/forgot_password_controller.dart';

import '../../../base/export_view.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPasswordController controller = Get.find();
    final formKey = GlobalKey<FormState>();
    Map<String, dynamic> data = {};

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
                          InkWell(
                            onTap: () => Get.back(),
                            child: Row(
                              spacing: 4.0,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedArrowLeft02,
                                  color: VColor.primary,
                                ),
                                VText(
                                  "Back to Login",
                                  color: VColor.primary,
                                  fontSize: 16.0,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            spacing: context.smPadding,
                            children: [
                              VText(
                                'Forgot Password?',
                                color: VColor.primary,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                              VText(
                                'Enter your email address and we\'ll send you instructions to reset your password.',
                                color: VColor.greyText,
                                align: TextAlign.center,
                              ),
                            ],
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
                          PrimaryButton(
                            'Reset Password',
                            onTap: () async {
                              final FormState form = formKey.currentState!;
                              if (!form.validate()) return;
                              form.save();
                              controller.submit(data["email"]);
                            },
                          ),
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

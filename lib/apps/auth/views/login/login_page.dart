import 'package:flutter_usecase_template/components/styles.dart';

import '../../../../base/export_view.dart';
import '../../../../components/buttons.dart';
import '../../../../components/inputs.dart';

import '../../../../configs/route_name.dart';
import '../../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());

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
                    key: _formKey,
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
                          FlutterLogo(
                            size: 64.0,
                          ),
                          Column(
                            spacing: context.smPadding,
                            children: [
                              VText(
                                'Welcome to AppName',
                                color: VColor.primary,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                              VText(
                                'Sign in to continue',
                                color: VColor.greyText,
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
                              _email = value!;
                            },
                          ),
                          Obx(() => VFormInput(
                                prefixIcon: HugeIcon(
                                  icon: HugeIcons.strokeRoundedSquareLock02,
                                  color: VColor.primary,
                                ),
                                obscure: controller.obscureText.value,
                                keyboardType: TextInputType.emailAddress,
                                hint: 'Enter your password',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password must not be empty';
                                  }
                                  return null;
                                },
                                onSaved: (String? value) {
                                  _password = value!;
                                },
                                suffixIcon: IconButton(
                                  onPressed: controller.toggleObscure,
                                  icon: HugeIcon(
                                    icon: controller.obscureText.isTrue
                                        ? HugeIcons.strokeRoundedView
                                        : HugeIcons.strokeRoundedViewOff,
                                    color: VColor.primary,
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: VText(
                              'Forgot password?',
                              color: VColor.primary,
                            ),
                          ),
                          PrimaryButton(
                            'Sign In',
                            onTap: () async {
                              final FormState form = _formKey.currentState!;
                              if (!form.validate()) return;
                              form.save();
                              controller.submitLogin(_email, _password);
                            },
                          ),
                          Row(
                            spacing: 4.0,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VText(
                                'Don\'t have an account?',
                                color: VColor.greyText,
                              ),
                              InkWell(
                                onTap: () => Get.toNamed(RouteName.register),
                                child: VText(
                                  'Sign Up',
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

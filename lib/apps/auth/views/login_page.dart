import '../../../base/export_view.dart';

import '../../../configs/route_name.dart';
import '../controllers/login_controller.dart';

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
            begin: .topRight,
            end: .bottomLeft,
            colors: [VColor.primary, VColor.accent],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        margin: .all(context.lgPadding),
                        padding: .symmetric(
                          horizontal: context.lgPadding,
                          vertical: context.xlPadding,
                        ),
                        decoration: BoxDecoration(
                          color: VColor.white,
                          borderRadius: .circular(16.0),
                          boxShadow: VStyle.shadow(),
                        ),
                        child: Column(
                          mainAxisSize: .min,
                          spacing: context.mdPadding,
                          children: [
                            FlutterLogo(size: 64.0),
                            Column(
                              spacing: context.smPadding,
                              children: [
                                VText(
                                  'Welcome to AppName',
                                  color: VColor.primary,
                                  fontSize: 24.0,
                                  fontWeight: .bold,
                                ),
                                VText(
                                  'Sign in to continue',
                                  color: VColor.greyText,
                                ),
                              ],
                            ),
                            VFormInput(
                              prefixIcon: Padding(
                                padding: const .all(12.0),
                                child: HugeIcon(
                                  icon: HugeIcons.strokeRoundedMail01,
                                  color: VColor.primary,
                                ),
                              ),
                              keyboardType: .number,
                              inputFormatters: [
                                ThousandsSeparatorInputFormatter(),
                              ],
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
                            Obx(
                              () => VFormInput(
                                prefixIcon: HugeIcon(
                                  icon: HugeIcons.strokeRoundedSquareLock02,
                                  color: VColor.primary,
                                ),
                                obscure: controller.obscureText.value,
                                keyboardType: .emailAddress,
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
                              ),
                            ),
                            Align(
                              alignment: .centerRight,
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed(RouteName.forgotPassword),
                                child: VText(
                                  'Forgot password?',
                                  color: VColor.primary,
                                ),
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
                              mainAxisAlignment: .center,
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
                                    fontWeight: .bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_usecase_template/apps/profile/controllers/change_password_controller.dart';
import 'package:flutter_usecase_template/base/export_view.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

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
        padding: EdgeInsets.all(context.mdPadding),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VText('Create a strong password to help protect your account.'),
              SizedBox(height: context.lgPadding),
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
                    keyboardType: TextInputType.emailAddress,
                    hint: 'Enter current password',
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
              SizedBox(height: context.mdPadding),
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
                    keyboardType: TextInputType.emailAddress,
                    hint: 'Enter new password',
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
                      onPressed: controller.toggleObscureNewPassword,
                      icon: HugeIcon(
                        icon: controller.obscureNewPassword.isTrue
                            ? HugeIcons.strokeRoundedView
                            : HugeIcons.strokeRoundedViewOff,
                        color: VColor.primary,
                      ),
                    ),
                  )),
              SizedBox(height: context.mdPadding),
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
                    keyboardType: TextInputType.emailAddress,
                    hint: 'Confirm new password',
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
                      onPressed: controller.toggleObscurePasswordConfirmation,
                      icon: HugeIcon(
                        icon: controller.obscureNewPasswordConfirmation.isTrue
                            ? HugeIcons.strokeRoundedView
                            : HugeIcons.strokeRoundedViewOff,
                        color: VColor.primary,
                      ),
                    ),
                  )),
              SizedBox(height: context.lgPadding),
              PrimaryButton(
                'Update Password',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

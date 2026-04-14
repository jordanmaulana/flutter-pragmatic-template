import 'package:flutter_usecase_template/apps/profile/controllers/delete_account_controller.dart';
import 'package:flutter_usecase_template/base/export_view.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    DeleteAccountController controller = Get.find();
    return Padding(
      padding: .all(context.mdPadding),
      child: Column(
        spacing: context.mdPadding,
        mainAxisSize: .min,
        children: [
          Row(
            spacing: context.smPadding,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedAlert01,
                color: VColor.error,
              ),
              VText('Delete Account', fontSize: 16.0, fontWeight: .bold),
            ],
          ),
          VText(
            'This action cannot be undone. Once you delete your account, all of your data will be permanently removed.',
          ),
          Container(
            width: double.infinity,
            padding: .all(context.mdPadding),
            decoration: BoxDecoration(
              color: VColor.errorAccent,
              borderRadius: .circular(8.0),
              border: .all(color: VColor.error),
            ),
            child: Column(
              spacing: context.mdPadding,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'To confirm, please type ',
                    style: TextStyle(color: VColor.error),
                    children: [
                      TextSpan(
                        text: 'DELETE',
                        style: TextStyle(
                          color: VColor.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' in the field below:',
                        style: TextStyle(color: VColor.error),
                      ),
                    ],
                  ),
                ),
                VFormInput(
                  hint: 'Type DELETE here',
                  fillColor: VColor.white,
                  textCapitalization: .characters,
                  onChanged: controller.onChange,
                ),
              ],
            ),
          ),
          Row(
            spacing: context.mdPadding,
            children: [
              Expanded(
                child: VSecondaryButton('Cancel', onTap: () => Get.back()),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (controller.isInputValid.isTrue) controller.submit();
                  },
                  child: Obx(
                    () => Opacity(
                      opacity: controller.isInputValid.isTrue ? 1.0 : 0.5,
                      child: Container(
                        width: .infinity,
                        height: 44.0,
                        alignment: .center,
                        decoration: BoxDecoration(
                          borderRadius: .circular(8.0),
                          color: VColor.error,
                        ),
                        child: VText(
                          'Delete Account',
                          color: VColor.white,
                          fontWeight: .w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

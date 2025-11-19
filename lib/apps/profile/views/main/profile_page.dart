import 'package:flutter_usecase_template/apps/profile/views/delete_account/delete_account_page.dart';
import 'package:flutter_usecase_template/apps/profile/views/main/email_icon.dart';
import 'package:flutter_usecase_template/configs/route_name.dart';

import '../../../../base/export_view.dart';

import '../../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(height: 120.0, color: VColor.primary),
                Expanded(child: Container(color: VColor.white)),
              ],
            ),
            Padding(
              padding: .all(context.lgPadding),
              child: Column(
                spacing: context.lgPadding,
                crossAxisAlignment: .start,
                children: [
                  VText(
                    "My Profile",
                    fontSize: 24,
                    color: VColor.white,
                    fontWeight: .bold,
                  ),
                  Container(
                    width: .infinity,
                    decoration: VStyle.boxShadow(),
                    padding: .all(context.mdPadding),
                    child: Column(
                      spacing: context.mdPadding,
                      crossAxisAlignment: .start,
                      children: [
                        VText("John Doe", fontWeight: .bold, fontSize: 16.0),
                        Row(
                          spacing: context.smPadding,
                          children: [
                            EmailIcon(),
                            Column(
                              crossAxisAlignment: .start,
                              children: [
                                VText(
                                  "Email",
                                  fontSize: 12.0,
                                  color: VColor.greyText,
                                ),
                                VText("johndoe@gmail.com"),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: context.mdPadding),
                        InkWell(
                          onTap: () => Get.toNamed(RouteName.changePassword),
                          child: Container(
                            width: .infinity,
                            padding: .symmetric(
                              horizontal: context.mdPadding,
                              vertical: context.smPadding,
                            ),
                            decoration: VStyle.corner(
                              color: VColor.tertiary,
                              radius: 8.0,
                            ),
                            child: VText(
                              "Change Password",
                              color: VColor.primary,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: .circular(16.0),
                                ),
                                child: Stack(
                                  children: [
                                    DeleteAccountPage(),
                                    Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: IconButton(
                                        onPressed: () => Get.back(),
                                        icon: const Icon(
                                          Icons.close,
                                          color: VColor.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: .infinity,
                            padding: .symmetric(
                              horizontal: context.mdPadding,
                              vertical: context.smPadding,
                            ),
                            decoration: VStyle.corner(
                              color: VColor.errorAccent,
                              radius: 8.0,
                            ),
                            child: VText("Delete Account", color: VColor.error),
                          ),
                        ),
                        Divider(),
                        InkWell(
                          onTap: () => controller.logout(),
                          child: Row(
                            spacing: context.smPadding,
                            mainAxisAlignment: .end,
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedLogout01,
                                color: VColor.greyText,
                              ),
                              VText("Logout"),
                            ],
                          ),
                        ),
                      ],
                    ),
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

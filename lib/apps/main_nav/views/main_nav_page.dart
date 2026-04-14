import 'package:flutter_usecase_template/apps/profile/views/main/profile_page.dart';

import '../../../base/export_view.dart';
import '../controllers/main_nav_controller.dart';

class MainNavPage extends StatelessWidget {
  const MainNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainNavController controller = Get.find();

    return Obx(() {
      return Scaffold(
        body: Builder(
          builder: (context) {
            switch (controller.index.value) {
              case 0:
                return Container();
              case 1:
                return Container();
              case 2:
                return const ProfilePage();
            }
            return Container();
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: VColor.white,
          type: .fixed,
          currentIndex: controller.index.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0.0,
          onTap: (v) => controller.setIndex(v),
          items: [
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedHome01,
                color: controller.index.value == 0
                    ? VColor.primary
                    : VColor.accent,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedInvoice01,
                color: controller.index.value == 1
                    ? VColor.primary
                    : VColor.accent,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                color: controller.index.value == 2
                    ? VColor.primary
                    : VColor.accent,
              ),
              label: '',
            ),
          ],
        ),
      );
    });
  }
}

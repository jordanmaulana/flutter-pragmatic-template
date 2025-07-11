import 'package:get/get.dart';

import '../../../ui/components/popup.dart';
import '../../../configs/route_name.dart';
import '../../profile/controllers/profile_controller.dart';
import '../usecases/login_usecase.dart';

class LoginController extends GetxController {
  final ProfileController _profileController = Get.find();
  final LoginUsecase _loginUsecase = Get.find();

  RxBool obscureText = true.obs;
  void toggleObscure() => obscureText(!obscureText.value);

  void submitLogin(String email, String password) async {
    VPopup.loading();
    final result = await _loginUsecase.invoke(email, password);
    VPopup.pop();
    result.when(
      onSuccess: (data) async {
        await _profileController.getProfile();
        Get.offAllNamed(RouteName.main);
      },
      onFailure: (message) {
        VPopup.error(message);
      },
    );
  }
}

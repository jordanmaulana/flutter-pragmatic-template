import 'package:flutter_usecase_template/apps/auth/usecases/register_usecase.dart';
import 'package:flutter_usecase_template/configs/route_name.dart';
import 'package:flutter_usecase_template/ui/components/popup.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final RegisterUsecase _registerUsecase = Get.find();

  RxBool obscurePassword = true.obs;
  void toggleObscurePassword() => obscurePassword(!obscurePassword.value);

  RxBool obscurePasswordConfirmation = true.obs;
  void toggleObscurePasswordConfirmation() =>
      obscurePasswordConfirmation(!obscurePasswordConfirmation.value);

  void submit(Map<String, String> data) async {
    VPopup.loading();
    final result = await _registerUsecase.invoke(data);
    VPopup.pop();
    result.when(
      onSuccess: (profile) {
        Get.offAllNamed(RouteName.main);
      },
      onFailure: (message) {
        VPopup.error(message);
      },
    );
  }
}

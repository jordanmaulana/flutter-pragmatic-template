import 'package:flutter_usecase_template/apps/auth/repo/auth_repo.dart';
import 'package:flutter_usecase_template/ui/components/toast.dart';
import 'package:get/get.dart';

class ForgotPasswordController {
  final AuthRepo _authRepo = Get.find();

  void submit(String email) async {
    final result = await _authRepo.forgotPassword(email);
    result.when(
      onSuccess: (data) {
        Get.back();
        VToast.success("Check your email for reset password link");
      },
      onFailure: (error) {
        VToast.error(error);
      },
    );
  }
}

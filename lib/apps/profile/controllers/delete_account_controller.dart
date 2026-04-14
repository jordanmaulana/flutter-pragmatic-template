import 'package:flutter_usecase_template/apps/profile/repo/profile_repo.dart';
import 'package:flutter_usecase_template/configs/route_name.dart';
import 'package:get/get.dart';

import '../../../ui/components/toast.dart';

class DeleteAccountController extends GetxController {
  final ProfileRepo _profileRepo = Get.find<ProfileRepo>();

  RxBool isLoading = false.obs;
  RxBool isInputValid = false.obs;

  void onChange(String? value) {
    if (value == 'DELETE') {
      isInputValid(true);
    } else {
      isInputValid(false);
    }
  }

  void submit() async {
    final result = await _profileRepo.deleteAccount();
    result.when(
      onSuccess: (data) {
        Get.offAllNamed(RouteName.main);
        VToast.success('Account deleted successfully!');
      },
      onFailure: (error) {
        VToast.error(error);
      },
    );
  }
}

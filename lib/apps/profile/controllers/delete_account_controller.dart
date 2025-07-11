import 'package:flutter_usecase_template/base/export_view.dart';

import '../../../ui/components/toast.dart';
import '../repo/profile_repo.dart';

class DeleteAccountController {
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
        Get.offAllNamed('/login');
        VToast.success('Account deleted successfully!');
      },
      onFailure: (error) {
        VToast.error(error);
      },
    );
  }
}

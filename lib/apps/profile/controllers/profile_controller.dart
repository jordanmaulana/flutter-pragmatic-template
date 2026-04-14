import 'package:flutter_usecase_template/apps/profile/repo/profile_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../configs/constants.dart';
import '../../../configs/route_name.dart';
import '../models/profile.dart';

class ProfileController extends GetxController {
  final ProfileRepo _profileRepo = Get.find();
  final GetStorage _box = Get.find();
  Rx<Profile?> profile = Rx<Profile?>(null);

  Future<void> getProfile() async {
    if (_box.hasData(Constants.savedProfile)) {
      profile.value = Profile.fromJson(_box.read(Constants.savedProfile));
    }

    final result = await _profileRepo.getProfile();
    result.when(
      onSuccess: (data) {
        profile.value = data;
      },
      onFailure: (message) {},
    );
  }

  void logout() {
    profile.value = null;
    _box.erase();
    Get.offAllNamed(RouteName.main);
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}

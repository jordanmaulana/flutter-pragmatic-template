import 'package:flutter_usecase_template/apps/auth/repo/auth_repo.dart';
import 'package:get_storage/get_storage.dart';

import '../../../base/resource.dart';
import '../../../configs/constants.dart';
import '../../profile/models/profile.dart';
import '../../profile/repo/profile_repo.dart';

class RegisterUsecase {
  final ProfileRepo _profileRepo;
  final AuthRepo _authRepo;
  final GetStorage _box;

  RegisterUsecase({
    required ProfileRepo profileRepo,
    required GetStorage box,
    required AuthRepo authRepo,
  }) : _profileRepo = profileRepo,
       _box = box,
       _authRepo = authRepo;

  Future<Resource<Profile, String>> invoke(Map<String, String> data) async {
    final result = await _authRepo.register(data);

    if (result.hasError) {
      return result.error!.toResourceFailure();
    }

    _box.write(Constants.token, result.data);
    return _profileRepo.getProfile();
  }
}

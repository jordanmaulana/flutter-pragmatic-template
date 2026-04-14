import 'package:flutter_usecase_template/apps/auth/repo/auth_repo.dart';
import 'package:get_storage/get_storage.dart';

import '../../../base/resource.dart';
import '../../../configs/constants.dart';
import '../../profile/models/profile.dart';
import '../../profile/repo/profile_repo.dart';

class LoginUsecase {
  final ProfileRepo _profileRepo;
  final AuthRepo _authRepo;
  final GetStorage _box;

  LoginUsecase({
    required ProfileRepo profileRepo,
    required GetStorage box,
    required AuthRepo authRepo,
  }) : _profileRepo = profileRepo,
       _box = box,
       _authRepo = authRepo;

  Future<Resource<Profile, String>> invoke(
    String email,
    String password,
  ) async {
    final result = await _authRepo.login(email, password);

    if (result.hasError) {
      return result.error!.toResourceFailure();
    }

    _box.write(Constants.token, result.data);
    return _profileRepo.getProfile();
  }
}

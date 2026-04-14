import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_usecase_template/apps/profile/repo/profile_repo.dart';
import 'package:flutter_usecase_template/configs/constants.dart';
import 'package:mockito/mockito.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  group('Testing Get Profile', () {
    final MockDioClient mockDioClient = MockDioClient();
    final MockGetStorage mockGetStorage = MockGetStorage();
    late ProfileRepo profileRepo;

    setUp(() {
      profileRepo = ProfileRepo(dioClient: mockDioClient, box: mockGetStorage);
    });

    /// Test has token in storage to prevent API call if there is no token.
    /// Purpose:
    /// If someone deleted the logic to check token in [ProfileRepo],
    /// the test will return fail
    test('No bearer token', () async {
      /// Mocking getstorage to return false when has data is called.
      when(mockGetStorage.hasData(Constants.token)).thenAnswer((
        realInvocation,
      ) {
        return false;
      });

      final result = await profileRepo.getProfile();

      /// Make sure storage has data is called by ProfileRepo
      verify(mockGetStorage.hasData(Constants.token)).called(1);

      /// Make sure the error string is 'Unauthenticated'
      expect(result.error, 'Unauthenticated');
    });

    /// Add more necessary test if available
  });
}

import 'package:flutter_usecase_template/api/dio_client.dart';
import 'package:flutter_usecase_template/base/resource.dart';

class AuthRepo {
  final DioClient _dioClient;

  AuthRepo({required DioClient dioClient}) : _dioClient = dioClient;

  Future<Resource<String, String>> login(String email, String password) async {
    try {
      final response = await _dioClient.post(
        '/api/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return "${response.data['token']}".toResourceSuccess();
    } on DioException catch (e) {
      return e.errorMessage.toResourceFailure();
    }
  }

  Future<Resource<String, String>> register(Map<String, String> data) async {
    try {
      final response = await _dioClient.post(
        '/api/register',
        data: data,
      );

      return '${response.data['token']}'.toResourceSuccess();
    } on DioException catch (e) {
      return e.errorMessage.toResourceFailure();
    }
  }

  Future<Resource<bool, String>> forgotPassword(String email) async {
    try {
      await _dioClient.post(
        '/api/forgot',
        data: {
          'email': email,
        },
      );

      return true.toResourceSuccess();
    } on DioException catch (e) {
      return e.errorMessage.toResourceFailure();
    }
  }
}

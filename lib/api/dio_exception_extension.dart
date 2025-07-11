import 'package:dio/dio.dart';
import 'package:get/get.dart';

/// This is the error parser. It is used as standard to parse error from API responses.
extension ResponseExtension on DioException {
  String get errorMessage {
    if (response != null) {
      String? error;
      try {
        if (response!.data is Map<String, dynamic>) {
          final data = response!.data as Map<String, dynamic>;
          if (data.containsKey('error')) {
            error = data['error'] as String?;
          } else {
            for (var entry in data.entries) {
              if (entry.value is String) {
                error = entry.value as String?;
              } else if (entry.value is List) {
                // If the value is a list, we can join them into a single string

                error = '${entry.key}, ${(entry.value as List).join(', ')}';
              }
            }
          }
        }

        Get.log('${response?.data}');
      } catch (e) {
        Get.log('Error $e');
      }

      switch (response!.statusCode) {
        case 400:
          return error ?? 'Please check your input';
        case 403:
          return error ?? 'Invalid access';
        case 404:
          return error ?? 'This service is no longer available';
        case 500:
          return error ?? 'Something went wrong on our end';
        default:
          return error ?? 'Something went wrong';
      }
    } else {
      /// Something happened in setting up or sending the request that triggered an Error
      return 'ERROR\n${requestOptions.uri.path.toString()}\n${toString()}';
    }
  }
}

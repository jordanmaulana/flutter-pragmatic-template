import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';

import '../configs/constants.dart';

export 'dio_exception_extension.dart';
export 'package:dio/dio.dart';
import '../extensions/my_string_extension.dart';

// If in browser, import 'package:dio/browser.dart'.

class DioClient extends DioForNative {
  final GetStorage _box;

  DioClient(this._box, {BaseOptions? options, bool useToken = true})
    : super(options) {
    interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) {
          /// Better to add function to error report an API. E.g: Sentry, Firebase Analytic
          Get.log(
            'API error ${e.requestOptions.method} ${e.response?.realUri} ${e.response?.statusCode} \n$e',
          );
          return handler.next(e);
        },
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          /// Add bearer token on API request.
          String? token = useToken ? _box.read(Constants.token) : null;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          Get.log('Request ${options.uri.toString()}');
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          /// Log anything necessary to easily debug
          Get.log(
            'API Response ${response.realUri} ${response.statusCode}: '
            '${response.statusMessage}\n'
            '${response.requestOptions.uri.queryParameters.prettyPrint}\n',
          );

          Get.log((response.data as Map<String, dynamic>).prettyPrint);

          return handler.next(response);
        },
      ),
    );
  }
}

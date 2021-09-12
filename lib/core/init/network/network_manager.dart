import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttermvvmtemplate/core/init/network/core_dio.dart';
import '../../base/model/base_model.dart';
import '../../constants/enums/preferences_keys_enum.dart';
import '../cache/locale_manager.dart';
import 'ICoreDio.dart';

class NetworkManager {
  static NetworkManager? _instance;

  static NetworkManager? get instance {
    if (_instance == null) {
      _instance = NetworkManager._init();
    }
    return _instance;
  }

  late ICoreDio coreDio;

  NetworkManager._init() {
    final baseOptions = BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com/",
      headers: {
        "val": LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN)
      },
    );
    _dio = Dio(baseOptions);

    coreDio = CoreDio(baseOptions);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // options.

        options.path += "oguz";
      },
      onResponse: (
        Response response,
        ResponseInterceptorHandler handler,
      ) {
        // baseOptions
        // return response.data;
      },
      onError: (DioError e, ErrorInterceptorHandler handler) {
        // return BaseError(e.message);
      },
    ));
  }

  // late Dio _dio;

  // Future dioGet<T extends BaseModel>(String path, T model) async {
  //   final response = await _dio.get(path);

  //   switch (response.statusCode) {
  //     case HttpStatus.ok:
  //       final responseBody = response.data;

  //       if (responseBody is List) {
  //         return responseBody.map((e) => model.fromJson(e)).toList();
  //       } else if (responseBody is Map) {
  //         return model.fromJson(responseBody as Map<String, Object>);
  //       }
  //       return responseBody;
  //     default:
  //   }
  // }
}

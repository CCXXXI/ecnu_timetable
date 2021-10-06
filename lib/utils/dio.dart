import 'package:dio/dio.dart';

final dio = Dio()
  ..interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    // logPrint: logger.v,
  ));

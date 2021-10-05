import 'package:dio/dio.dart';

import 'logger.dart';

final dio = Dio()
  ..interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: logger.v,
  ));

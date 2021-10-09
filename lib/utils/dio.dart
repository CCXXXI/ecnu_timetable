import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:loggy/loggy.dart';

final dio = Dio()
  ..interceptors.add(LoggyDioInterceptor(
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    requestLevel: LogLevel.debug,
    responseLevel: LogLevel.debug,
  ));

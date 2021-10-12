import 'package:cookie_jar/cookie_jar.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:loggy/loggy.dart';

final cookieJar = CookieJar();

/// The default Dio instance used by all production code.
/// Test code may use a fake one.
final defaultDio = Dio()
  ..interceptors.addAll([
    LoggyDioInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      requestLevel: LogLevel.debug,
      responseLevel: LogLevel.debug,
    ),
    CookieManager(cookieJar),
  ]);

const _repo = 'CCXXXI/ecnu_timetable';

class Api {
  static const _suckers = [
    'https://api.vience.cn/api/tiangou',
    'http://api.ay15.cn/api/tiangou/api.php',
  ];

  static String get randomSucker => randomChoice(_suckers);

  static const releases = 'https://api.github.com/repos/$_repo/releases';
}

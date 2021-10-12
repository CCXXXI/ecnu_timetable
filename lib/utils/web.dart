import 'package:cookie_jar/cookie_jar.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:loggy/loggy.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

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

extension Launch on String {
  void launch() => launcher.launch(this);
}

const _repo = 'CCXXXI/ecnu_timetable';

class Api {
  static const _suckers = [
    'https://api.vience.cn/api/tiangou',
    'http://api.ay15.cn/api/tiangou/api.php',
  ];

  static String get randomSucker => randomChoice(_suckers);

  static const releases = 'https://api.github.com/repos/$_repo/releases';

  static const _baidu = 'https://aip.baidubce.com';

  static const baiduToken = '$_baidu/oauth/2.0/token';
  static const baiduOcr = '$_baidu/rest/2.0/ocr/v1/general_basic';
}

class Url {
// region GitHub
  static const _gh = 'https://github.com';

  static const latest = '$_gh/$_repo/releases/latest';

  static String version(String v) => '$_gh/$_repo/releases/tag/v$v';
  static const issues = '$_gh/$_repo/issues';

// endregion

// region ECNU
  static const _ecnu = 'ecnu.edu.cn';

  static const uOffice = 'http://www.u-office.$_ecnu';
  static const calendar = '$uOffice/xiaoli';
  static const announcements = 'https://www.$_ecnu/tzgg.htm';
  static const map = 'https://eoffice.$_ecnu/ecnu3d/main.psp';
  static const bus = 'http://houqin.$_ecnu/28837/list.psp';
  static const mirrors = 'https://mirrors.$_ecnu';
  static const vpn = 'https://docs.$_ecnu/index/Network/vpn.html';

// endregion

// region idc
  static const _cas = 'https://portal1.$_ecnu/cas';
  static const _eams = 'https://applicationnewjw.$_ecnu/eams';

  static const portal = '$_cas/login?service=$_eams/home.action';
  static const captcha = '$_cas/code';
  static const ids = '$_eams/courseTableForStd!index.action';
  static const table = '$_eams/courseTableForStd!courseTable.action';
// endregion
}

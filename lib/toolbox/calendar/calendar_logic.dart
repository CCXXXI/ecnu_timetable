import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:universal_html/parsing.dart';

import '../../utils/dio.dart';
import '../../utils/log.dart';

class CalendarLogic extends GetxController with L {
  final Dio dio;

  CalendarLogic({Dio? dio}) : dio = dio ?? defaultDio;

  static const url = 'http://www.u-office.ecnu.edu.cn/xiaoli/main.htm';

  @override
  void onInit() {
    getCalendar();
    super.onInit();
  }

  final imgUrl = ''.obs;

  void getCalendar() async {
    try {
      final r = await dio.get(url);
      final document = parseHtmlDocument(r.data);
      final src = document.querySelector('img')!.attributes['src'];
      imgUrl.value = 'http://www.u-office.ecnu.edu.cn$src';
    } catch (e) {
      l.error(e);
      Get.snackbar('获取校历失败', e.toString());
    }
  }
}

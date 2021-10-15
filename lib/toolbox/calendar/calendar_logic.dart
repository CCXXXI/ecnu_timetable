import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:universal_html/parsing.dart';

import '../../utils/log.dart';
import '../../utils/web.dart';

class CalendarLogic extends GetxController with L {
  final Dio dio;

  CalendarLogic({Dio? dio}) : dio = dio ?? defaultDio;

  @override
  void onInit() {
    getCalendar();
    super.onInit();
  }

  final imgUrl = ''.obs;

  void getCalendar() async {
    try {
      final r = await dio.get(Url.calendar);
      final document = parseHtmlDocument(r.data);
      final src = document.querySelector('img')?.parent?.attributes['href'];
      imgUrl.value = Url.uOffice + src!;
    } catch (e) {
      l.error(e);
      Get.snackbar('获取校历失败', e.toString());
    }
  }
}

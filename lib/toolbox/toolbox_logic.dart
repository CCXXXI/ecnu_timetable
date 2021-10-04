import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolboxLogic extends GetxController {
  final calendarUrl = 'http://www.u-office.ecnu.edu.cn/xiaoli/main.htm';

  void calendarOnTap() async => await launch(calendarUrl);
}

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolboxLogic extends GetxController {
  void calendarOnTap() =>
      launch('http://www.u-office.ecnu.edu.cn/xiaoli/main.htm');

  void announcementsOnTap() => launch('https://www.ecnu.edu.cn/tzgg.htm');
}

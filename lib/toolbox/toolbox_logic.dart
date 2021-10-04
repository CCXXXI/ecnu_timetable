import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolboxLogic extends GetxController {
  void Function() l(String url) => () => launch(url);
}

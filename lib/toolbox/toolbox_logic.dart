import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class ToolboxLogic extends GetxController {
  void Function() l(String url) => () => launcher.launch(url);
}

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/gu.dart';

class ToolboxLogic extends GetxController {
  void Function() l(String url) => () => launch(url);

  final suckerEnabled = Settings.getValue('toolbox.sucker', false).obs;

  updateSuckerEnabled(bool v) => suckerEnabled.value = v;


  void suckerOnTap() {
    gu();
  }
}

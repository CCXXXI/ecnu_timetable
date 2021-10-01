import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import '../utils/gu.dart';

class SettingsLogic extends GetxController {
  bool get loggedIn => id != null;

  String? get id => Settings.getValue('id', null);

  String? get username => Settings.getValue('username', null);

  void login() => gu(); // todo
}

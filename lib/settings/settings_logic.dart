import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import '../utils/gu.dart';
import 'theme.dart' as theme;

class SettingsLogic extends GetxController {
  bool get loggedIn => id != null;

  String? get id => Settings.getValue('id', null);

  String? get username => Settings.getValue('username', null);

  void login() => gu(); // todo

  void updateTheme(_) => theme.updateTheme();
}

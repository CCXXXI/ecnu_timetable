import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());

  @override
  Widget build(BuildContext context) {
    return const Placeholder(color: Colors.blue);
  }
}

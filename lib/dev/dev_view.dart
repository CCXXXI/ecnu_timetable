import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import '../toolbox/toolbox_logic.dart';
import 'dev_logic.dart';

class DevPage extends StatelessWidget {
  DevPage({Key? key}) : super(key: key);

  final logic = Get.put(DevLogic());
  final toolboxLogic = Get.find<ToolboxLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('开发者选项')),
      body: ListView(
        children: [
          SettingsGroup(
            title: '工具箱',
            children: [
              SwitchSettingsTile(
                title: 'sucker',
                settingKey: 'toolbox.sucker',
                onChange: (v) => toolboxLogic.updateSuckerEnabled(v),
              ),
            ],
          ),
          SettingsGroup(
            title: '杂项',
            children: [
              ListTile(
                title: const Text('Trivia'),
                onTap: logic.triviaOnTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

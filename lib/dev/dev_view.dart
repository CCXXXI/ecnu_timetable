import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

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
              SwitchSettingsTile(
                title: 'cheater',
                settingKey: 'toolbox.cheater',
                onChange: (v) => toolboxLogic.updateCheaterEnabled(v),
              ),
              SwitchSettingsTile(
                title: 'juan',
                settingKey: 'toolbox.juan',
                onChange: (v) => toolboxLogic.updateJuanEnabled(v),
              ),
            ],
          ),
          SettingsGroup(
            title: '日志',
            children: [
              DropDownSettingsTile(
                title: 'level',
                settingKey: 'log.level',
                selected: 0,
                values: _logLevels,
              ),
              DropDownSettingsTile(
                title: 'stackTraceLevel',
                settingKey: 'log.stackTraceLevel',
                selected: 5,
                values: _logLevels,
              ),
              SwitchSettingsTile(
                title: 'includeCallerInfo',
                settingKey: 'log.includeCallerInfo',
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

final _logLevels = {
  for (var i = 0; i != LogLevel.values.length; ++i)
    i: LogLevel.values[i].toString(),
};

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import '../utils/database.dart';
import 'dev_logic.dart';

class DevPage extends StatelessWidget {
  DevPage({Key? key}) : super(key: key);

  final logic = Get.put(DevLogic());

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
                defaultValue: toolbox.sucker,
                onChange: logic.suckerOnChanged,
              ),
              SwitchSettingsTile(
                title: 'cheater',
                settingKey: 'toolbox.cheater',
                defaultValue: toolbox.cheater,
                onChange: logic.cheaterOnChanged,
              ),
              SwitchSettingsTile(
                title: 'juan',
                settingKey: 'toolbox.juan',
                defaultValue: toolbox.juan,
                onChange: logic.juanOnChanged,
              ),
            ],
          ),
          SettingsGroup(
            title: '日志',
            children: [
              SimpleDropDownSettingsTile(
                title: 'level',
                settingKey: 'log.level',
                selected: log.level,
                values: log.levels,
                onChange: logic.levelOnChanged,
              ),
              SimpleDropDownSettingsTile(
                title: 'stackTraceLevel',
                settingKey: 'log.stackTraceLevel',
                selected: log.stackTraceLevel,
                values: log.levels,
                onChange: logic.stackTraceLevelOnChanged,
              ),
              SwitchSettingsTile(
                title: 'includeCallerInfo',
                settingKey: 'log.includeCallerInfo',
                defaultValue: log.includeCallerInfo,
                onChange: logic.includeCallerInfoOnChanged,
              ),
              ListTile(
                title: const Text('log'),
                onTap: logic.logOnTap,
              ),
              const Divider(),
            ],
          ),
          SettingsGroup(
            title: '杂项',
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  title: const Text('trivia'),
                  onTap: logic.triviaOnTap,
                ),
                ListTile(
                  title: const Text('cheater'),
                  onTap: logic.cheaterOnTap,
                ),
                ListTile(
                  title: const Text('gu'),
                  onTap: logic.guOnTap,
                ),
                ListTile(
                  title: const Text('loading'),
                  onTap: logic.loadingOnTap,
                ),
              ],
            ).toList(),
          ),
        ],
      ),
    );
  }
}

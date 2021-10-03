import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/messages.dart';
import 'settings_logic.dart';
import 'theme.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        user(),
        const Divider(),
        SettingsGroup(title: '主题', children: [dark(), font(), color()]),
        SettingsGroup(title: '杂项', children: [launchPage()]),
      ],
    );
  }

  Widget user() => logic.loggedIn
      ? ListTile(
          leading: const Icon(Icons.person),
          trailing: const Icon(Icons.logout),
          title: Text(logic.username!),
          subtitle: Text(logic.id!),
        )
      : ListTile(
          leading: const FaIcon(FontAwesomeIcons.userSecret),
          trailing: const Icon(Icons.login),
          title: const Text('无名者'),
          subtitle: const Text('点击以登录'),
          onTap: logic.login,
        );

// region theme
  Widget dark() => DropDownSettingsTile(
        title: '深色模式',
        settingKey: 'themeMode',
        values: {
          ThemeMode.system.index: '跟随系统',
          ThemeMode.dark.index: '开',
          ThemeMode.light.index: '关',
        },
        selected: ThemeMode.system.index,
        onChange: logic.updateTheme,
      );

  Widget font() => DropDownSettingsTile(
        title: '字体',
        settingKey: 'font',
        values: fonts,
        selected: notoSans,
        onChange: logic.updateTheme,
      );

  Widget color() => SwitchSettingsTile(
        title: '自定义',
        settingKey: 'overrideColor',
        onChange: logic.updateTheme,
        childrenIfEnabled: [
          for (final c in ['primary', 'secondary', 'surface'])
            ColorPickerSettingsTile(
              settingKey: 'color.$c',
              title: c,
              defaultValue: ecnuColor,
              onChange: logic.updateTheme,
            ),
        ],
      );

//endregion

// region misc
  Widget launchPage() => DropDownSettingsTile(
        title: '启动页',
        settingKey: 'launchPage',
        values: const {
          0: '工具箱',
          1: '课程表',
          2: '设置',
        },
        selected: 1,
      );

// endregion
}

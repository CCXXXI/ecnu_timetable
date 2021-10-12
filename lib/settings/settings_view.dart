import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/loading.dart';
import '../utils/string.dart';
import 'settings_logic.dart';
import 'theme.dart';
import 'trivia.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.put(SettingsLogic());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(
          children: [
            SettingsGroup(title: '主题', children: [dark, font, color]),
            SettingsGroup(title: '杂项', children: [launchPage]),
            SettingsGroup(
              title: '关于',
              children: ListTile.divideTiles(
                context: context,
                tiles: [curVer, latestVer, feedback, licenses],
              ).toList(),
            ),
            const Divider(),
            trivia,
          ],
        ),
      ),
    );
  }

// region theme
  Widget get dark => DropDownSettingsTile(
        title: '深色模式',
        settingKey: 'theme.mode',
        values: {
          ThemeMode.system.index: '跟随系统',
          ThemeMode.dark.index: '开',
          ThemeMode.light.index: '关',
        },
        selected: ThemeMode.system.index,
        onChange: logic.updateTheme,
      );

  Widget get font => DropDownSettingsTile(
        title: '字体',
        settingKey: 'theme.font',
        values: fonts,
        selected: notoSans,
        onChange: logic.updateTheme,
      );

  Widget get color => SwitchSettingsTile(
        title: '自定义',
        settingKey: 'theme.overrideColor',
        onChange: logic.updateTheme,
        childrenIfEnabled: [
          for (final c in ['primary', 'secondary', 'surface'])
            ColorPickerSettingsTile(
              settingKey: 'theme.color.$c',
              title: c,
              defaultValue: ecnuColor,
              onChange: logic.updateTheme,
            ),
        ],
      );

//endregion

// region misc
  Widget get launchPage => DropDownSettingsTile(
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

// region about
  Widget get curVer => ListTile(
        title: const Text('当前版本'),
        trailing: const Text(version),
        onTap: logic.curVerOnTap,
      );

  Widget get latestVer => Obx(() => ListTile(
        title: const Text('最新版本'),
        trailing: logic.latestVer.value == null
            ? Loading()
            : logic.latestVer.value!.isEmpty
                ? IconButton(
                    onPressed: logic.updateVerInfo,
                    icon: const FaIcon(FontAwesomeIcons.redo),
                  )
                : Badge(
                    child: Text(logic.latestVer.value!),
                    badgeContent: FaIcon(
                      logic.updateAvailable
                          ? FontAwesomeIcons.exclamation
                          : FontAwesomeIcons.check,
                      size: 16,
                    ),
                    badgeColor:
                        logic.updateAvailable ? ecnuColor : Colors.green,
                    position: BadgePosition.topStart(top: -4, start: -32),
                  ),
        onTap: logic.latestVerOnTap,
      ));

  Widget get feedback => ListTile(
        title: const Text('反馈'),
        trailing: const FaIcon(FontAwesomeIcons.github),
        onTap: logic.feedbackOnTap,
      );

  Widget get licenses => AboutListTile(
        applicationIcon: const Image(
          image: ResizeImage(
            AssetImage('assets/images/app_icon.png'),
            width: 42,
          ),
          width: 42, // fix bug on web
        ),
        applicationLegalese: license,
        applicationVersion: release,
        child: const Text('许可协议'),
      );

// endregion

  Widget get trivia => ListTile(
        leading: const FaIcon(FontAwesomeIcons.lightbulb),
        title: randomTrivia,
      );
}

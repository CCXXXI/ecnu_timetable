import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../timetable/timetable_menu/timetable_menu_view.dart';
import '../toolbox/toolbox_menu/toolbox_menu_view.dart';
import '../utils/database.dart';
import '../utils/loading.dart';
import '../utils/string.dart';
import '../utils/web.dart';
import 'settings_logic.dart';
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
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.th),
              title: const Text('课程表'),
              subtitle: Text('导入/修改/导出'.s),
              onTap: () => Get.to(() => TimetableMenuPage()),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.toolbox),
              title: const Text('工具箱'),
              subtitle: const Text('调整排序'),
              onTap: () => Get.to(() => ToolboxMenuPage()),
            ),
            SettingsGroup(
              title: '主题',
              children: [
                SimpleDropDownSettingsTile(
                  title: '深色模式',
                  settingKey: 'theme.mode',
                  values: theme.modes,
                  selected: theme.mode,
                  onChange: logic.modeOnChanged,
                ),
                SimpleDropDownSettingsTile(
                  title: '字体',
                  settingKey: 'theme.font',
                  values: theme.fonts,
                  selected: theme.font,
                  onChange: logic.fontOnChanged,
                ),
                SwitchSettingsTile(
                  title: '自定义',
                  settingKey: 'theme.overrideColor',
                  onChange: logic.overrideColorOnChanged,
                  childrenIfEnabled: [
                    ColorPickerSettingsTile(
                      settingKey: 'theme.color.primary',
                      title: 'primary',
                      defaultValue: theme.primary,
                      onChange: logic.primaryOnChanged,
                    ),
                    ColorPickerSettingsTile(
                      settingKey: 'theme.color.secondary',
                      title: 'secondary',
                      defaultValue: theme.secondary,
                      onChange: logic.secondaryOnChanged,
                    ),
                    ColorPickerSettingsTile(
                      settingKey: 'theme.color.surface',
                      title: 'surface',
                      defaultValue: theme.surface,
                      onChange: logic.surfaceOnChanged,
                    ),
                  ],
                ),
              ],
            ),
            SettingsGroup(
              title: '杂项',
              children: [
                SimpleDropDownSettingsTile(
                  title: '启动页',
                  settingKey: 'misc.launchPage',
                  values: misc.pages,
                  selected: misc.launchPage,
                  onChange: logic.launchPageOnChanged,
                ),
              ],
            ),
            SettingsGroup(
                title: '关于',
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      title: const Text('当前版本'),
                      trailing: const Text(version),
                      onTap: Url.version(version).launch,
                    ),
                    Obx(
                      () => ListTile(
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
                                    badgeColor: logic.updateAvailable
                                        ? Colors.orange
                                        : Colors.green,
                                    position: BadgePosition.topStart(
                                      top: -4,
                                      start: -32,
                                    ),
                                  ),
                        onTap: Url.latest.launch,
                      ),
                    ),
                    ListTile(
                      title: const Text('反馈'),
                      trailing: const FaIcon(FontAwesomeIcons.github),
                      onTap: Url.issues.launch,
                    ),
                    AboutListTile(
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
                    ),
                  ],
                ).toList()),
            const Divider(),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.lightbulb),
              title: randomTrivia,
            ),
          ],
        ),
      ),
    );
  }
}

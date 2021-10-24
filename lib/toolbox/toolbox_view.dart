import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiver/iterables.dart';

import '../utils/database.dart';
import '../utils/loading.dart';
import '../utils/string.dart';
import '../utils/web.dart';
import 'toolbox_logic.dart';
import 'toolbox_menu/toolbox_menu_view.dart';

class ToolboxPage extends StatelessWidget {
  ToolboxPage({Key? key}) : super(key: key);

  final logic = Get.put(ToolboxLogic());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: conf.listenable(keys: ['toolbox']),
      builder: (_, __, ___) => GridView.extent(
        maxCrossAxisExtent: 512,
        childAspectRatio: pi,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: tools.map((e) => e.toCard()).toList(),
      ),
    );
  }
}

List<Tool> get tools {
  final logic = Get.find<ToolboxLogic>();

  final tools_ = [
    Tool(
      FontAwesomeIcons.dog,
      '/sucker',
      Obx(
        () => logic.sucker.isEmpty
            ? Loading()
            : Text(
                logic.sucker.value.length < 16
                    ? logic.sucker.value
                    : logic.sucker.value.substring(0, 16) + '……',
              ),
      ),
      onTap: logic.suckerOnTap,
      enabled: !GetPlatform.isWeb,
    ),
    Tool(
      FontAwesomeIcons.cat,
      '/cheater',
      Obx(
        () => logic.cheater.isEmpty
            ? Loading()
            : Text(
                logic.cheater.value.length < 16
                    ? logic.cheater.value
                    : logic.cheater.value.substring(0, 16) + '……',
              ),
      ),
      onTap: logic.cheaterOnTap,
    ),
    Tool(
      FontAwesomeIcons.graduationCap,
      '卷课意愿值估算',
      const Text('仅供参考'),
      onTap: logic.juanOnTap,
    ),
    Tool(
      FontAwesomeIcons.calendarAlt,
      '校历',
      const Text('长按打开网页版'),
      onTap: logic.calendarOnTap,
      onLongPress: Url.calendar.launch,
    ),
    Tool(
      FontAwesomeIcons.scroll,
      '公告',
      const Text('善用搜索'),
      onTap: Url.announcements.launch,
    ),
    Tool(
      FontAwesomeIcons.mapMarked,
      '校内地图',
      const Text('2D/3D'),
      onTap: Url.map.launch,
    ),
    Tool(
      FontAwesomeIcons.bus,
      '校车时刻表',
      Text('需要连学校Wifi/VPN'.s),
      onTap: Url.bus.launch,
    ),
    Tool(
      FontAwesomeIcons.cube,
      'ECNU软件镜像站'.s,
      const Text('内容很少'),
      onTap: Url.mirrors.launch,
    ),
    Tool(
      FontAwesomeIcons.key,
      '学校VPN'.s,
      const Text('对校外网站有减速作用'),
      onTap: Url.vpn.launch,
    ),
  ];

  return range(tools_.length)
      .cast<int>()
      .map((i) => tools_[toolbox.order[i]])
      .toList(growable: false);
}

class Tool {
  const Tool(
    this.leading,
    this.title,
    this.subtitle, {
    this.onTap,
    this.onLongPress,
    this.enabled = true,
  });

  final IconData leading;
  final String title;
  final Widget subtitle;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final bool enabled;

  ToolCard toCard() => ToolCard(
        leading,
        title,
        subtitle,
        onTap: onTap,
        onLongPress: onLongPress,
        enabled: enabled,
      );

  ToolTile toTile() => ToolTile(
        leading,
        title,
        key: Key(title),
      );
}

class ToolCard extends StatelessWidget {
  const ToolCard(
    this.leading,
    this.title,
    this.subtitle, {
    Key? key,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
  }) : super(key: key);

  final IconData leading;
  final String title;
  final Widget subtitle;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      style: ElevatedButton.styleFrom(
        primary: context.theme.colorScheme.background,
        onPrimary: context.theme.colorScheme.onBackground,
        shadowColor: context.theme.colorScheme.onBackground,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 256),
          child: ListTile(
            leading: FaIcon(leading),
            title: Text(title),
            subtitle: subtitle,
            mouseCursor: MouseCursor.uncontrolled,
          ),
        ),
      ),
    );
  }
}

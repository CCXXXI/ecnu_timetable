import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/messages.dart';
import 'toolbox_logic.dart';

class ToolboxPage extends StatelessWidget {
  ToolboxPage({Key? key}) : super(key: key);

  final logic = Get.put(ToolboxLogic());

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 512,
      childAspectRatio: pi,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        Tool(
          FontAwesomeIcons.calendarAlt,
          '校历',
          '师大还在用http'.s,
          onTap: logic.l('http://www.u-office.ecnu.edu.cn/xiaoli/main.htm'),
        ),
        Tool(
          FontAwesomeIcons.scroll,
          '公告',
          '善用搜索',
          onTap: logic.l('https://www.ecnu.edu.cn/tzgg.htm'),
        ),
        Tool(
          FontAwesomeIcons.bus,
          '校车时刻表',
          '需要连学校Wifi/VPN'.s,
          onTap: logic.l('http://houqin.ecnu.edu.cn/28837/list.psp'),
        ),
      ],
    );
  }
}

class Tool extends StatelessWidget {
  const Tool(this.leading, this.title, this.subtitle,
      {Key? key, this.onTap, this.onLongPress})
      : super(key: key);
  final IconData leading;
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      onLongPress: onLongPress,
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
            subtitle: Text(subtitle),
            mouseCursor: MouseCursor.uncontrolled,
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/loading.dart';
import '../utils/messages.dart';
import 'toolbox_logic.dart';

class ToolboxPage extends StatelessWidget {
  ToolboxPage({Key? key}) : super(key: key);

  final logic = Get.put(ToolboxLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.extent(
        maxCrossAxisExtent: 512,
        childAspectRatio: pi,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          if (logic.suckerEnabled.isTrue)
            Tool(
              FontAwesomeIcons.dog,
              '/sucker',
              logic.sucker.value.length < 16
                  ? logic.sucker.value
                  : logic.sucker.value.substring(0, 16) + '……',
              onTap: logic.suckerOnTap,
              enabled: !GetPlatform.isWeb,
            ),
          if (logic.cheaterEnabled.isTrue)
            Tool(
              FontAwesomeIcons.cat,
              '/cheater',
              logic.cheater.value.length < 16
                  ? logic.cheater.value
                  : logic.cheater.value.substring(0, 16) + '……',
              onTap: logic.cheaterOnTap,
            ),
          if (logic.juanEnabled.isTrue)
            Tool(
              FontAwesomeIcons.graduationCap,
              '卷课意愿值估算',
              '仅供参考',
              onTap: logic.juanOnTap,
            ),
          Tool(
            FontAwesomeIcons.calendarAlt,
            '校历',
            '师大还在用http'.s,
            onTap: logic.url('http://www.u-office.ecnu.edu.cn/xiaoli/main.htm'),
          ),
          Tool(
            FontAwesomeIcons.scroll,
            '公告',
            '善用搜索',
            onTap: logic.url('https://www.ecnu.edu.cn/tzgg.htm'),
          ),
          Tool(
            FontAwesomeIcons.mapMarked,
            '校内地图',
            '2D/3D',
            onTap: logic.url('https://3dmap.ecnu.edu.cn/'),
          ),
          Tool(
            FontAwesomeIcons.bus,
            '校车时刻表',
            '需要连学校Wifi/VPN'.s,
            onTap: logic.url('http://houqin.ecnu.edu.cn/28837/list.psp'),
          ),
          Tool(
            FontAwesomeIcons.cube,
            'ECNU软件镜像站'.s,
            '内容很少',
            onTap: logic.url('https://mirrors.ecnu.edu.cn/'),
          ),
          Tool(
            FontAwesomeIcons.key,
            '学校VPN'.s,
            '对校外网站有减速作用',
            onTap: logic.url('https://docs.ecnu.edu.cn/index/Network/vpn.html'),
          ),
        ],
      );
    });
  }
}

class Tool extends StatelessWidget {
  const Tool(this.leading, this.title, this.subtitle,
      {Key? key, this.onTap, this.onLongPress, this.enabled = true})
      : super(key: key);
  final IconData leading;
  final String title;
  final String subtitle;
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
            subtitle: subtitle.isEmpty ? Loading() : Text(subtitle),
            mouseCursor: MouseCursor.uncontrolled,
          ),
        ),
      ),
    );
  }
}

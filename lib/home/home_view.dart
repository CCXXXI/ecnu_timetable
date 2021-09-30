import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/messages.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isPortrait ? AppBar() : null,
      body: Row(
        children: [
          if (context.isLandscape)
            Obx(() {
              return NavigationRail(
                selectedIndex: idxMap[logic.idx.value],
                onDestinationSelected: logic.onDestinationSelected,
                destinations: [
                  for (final i in idxMap)
                    NavigationRailDestination(
                      label: _labelIconList[i].label,
                      icon: _labelIconList[i].icon,
                    ),
                ],
              );
            }),
          Expanded(
            child: PageView(
              controller: logic.pageController,
              onPageChanged: null, // todo
              physics: context.isLandscape
                  ? const NeverScrollableScrollPhysics()
                  : null,
              children: const [
                Placeholder(color: Colors.red),
                Placeholder(color: Colors.green),
                Placeholder(color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: context.isPortrait
          ? Obx(() {
              return BottomNavyBar(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                selectedIndex: logic.idx.value,
                onItemSelected: logic.onItemSelected,
                items: [
                  for (final labelIcon in _labelIconList)
                    BottomNavyBarItem(
                      title: labelIcon.label,
                      icon: labelIcon.icon,
                    ),
                ],
              );
            })
          : null,
    );
  }
}

class _LabelIcon {
  final Widget label;
  final Widget icon;

  _LabelIcon(String label, this.icon) : label = Text(label.t);
}

final _labelIconList = [
  _LabelIcon('Toolbox', const FaIcon(FontAwesomeIcons.toolbox)),
  _LabelIcon('Timetable', const Icon(Icons.calendar_view_month)),
  _LabelIcon('Settings', const Icon(Icons.settings)),
];

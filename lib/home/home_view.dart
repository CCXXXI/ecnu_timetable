import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../settings/settings_view.dart';
import '../timetable/timetable_view.dart';
import '../toolbox/toolbox_view.dart';
import '../utils/messages.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isPortrait
          ? AppBar(
              title: Text('求实创造 为人师表'.t),
            )
          : null,
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
                      label: _labelIcons[i].label,
                      icon: _labelIcons[i].icon,
                    ),
                ],
              );
            }),
          Expanded(
            child: context.isPortrait
                ? Obx(() {
                    return PageView(
                      controller: logic.pageController,
                      onPageChanged: logic.onPageChanged,
                      physics: logic.isAnimating.isTrue
                          ? const NeverScrollableScrollPhysics()
                          : null,
                      children: _pages,
                    );
                  })
                : PageView(
                    controller: logic.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _pages,
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
                  for (final labelIcon in _labelIcons)
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

final _labelIcons = [
  _LabelIcon('Toolbox', const FaIcon(FontAwesomeIcons.toolbox)),
  _LabelIcon('Timetable', const Icon(Icons.calendar_view_month)),
  _LabelIcon('Settings', const Icon(Icons.settings)),
];

final _pages = [ToolboxPage(), TimetablePage(), SettingsPage()];

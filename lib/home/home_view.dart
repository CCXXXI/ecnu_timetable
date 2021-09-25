import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../messages.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: logic.pageController,
        onPageChanged: logic.onPageChanged,
        children: const [
          Placeholder(),
          Placeholder(),
          Placeholder(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          selectedIndex: logic.idx.value,
          onItemSelected: logic.onItemSelected,
          items: [
            BottomNavyBarItem(
              title: Text('Timetable'.t),
              icon: const Icon(Icons.calendar_view_month),
            ),
            BottomNavyBarItem(
              title: Text('Toolbox'.t),
              icon: const FaIcon(FontAwesomeIcons.toolbox),
            ),
            BottomNavyBarItem(
              title: Text('Settings'.t),
              icon: const Icon(Icons.settings),
            ),
          ],
        );
      }),
    );
  }
}

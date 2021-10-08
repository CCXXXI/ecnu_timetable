import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import 'timetable_menu_logic.dart';

class TimetableMenuPage extends StatelessWidget {
  TimetableMenuPage({Key? key}) : super(key: key);

  final logic = Get.put(TimetableMenuLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('课程表'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            children: [
              SettingsGroup(
                title: '导入',
                children: ListTile.divideTiles(
                  context: context,
                  tiles: [],
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

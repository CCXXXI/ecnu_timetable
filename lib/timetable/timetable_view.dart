import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'timetable_logic.dart';

class TimetablePage extends StatelessWidget {
  TimetablePage({Key? key}) : super(key: key);

  final logic = Get.put(TimetableLogic());

  @override
  Widget build(BuildContext context) {
    if (true) {
      return const TextButton(
        onPressed: TimetableLogic.openMenu,
        child: Text('NO DATA'),
      );
    }
  }
}

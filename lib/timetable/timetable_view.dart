import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

import '../utils/database.dart';
import 'timetable_logic.dart';

class TimetablePage extends StatelessWidget {
  TimetablePage({Key? key}) : super(key: key);

  final logic = Get.put(TimetableLogic());

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const TextButton(
        onPressed: TimetableLogic.openMenu,
        child: Text('NO DATA'),
      );
    } else {
      return LayoutGrid(columnSizes: const [auto], rowSizes: const [auto]);
    }
  }
}

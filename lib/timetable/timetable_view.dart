import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/database.dart';
import 'timetable_logic.dart';

class TimetablePage extends StatelessWidget {
  TimetablePage({Key? key}) : super(key: key);

  final logic = Get.put(TimetableLogic());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: courses.listenable(),
      builder: (_, __, ___) {
        if (courses.isEmpty) {
          return const TextButton(
            onPressed: TimetableLogic.openMenu,
            child: Text('NO DATA'),
          );
        } else {
          return LayoutGrid(columnSizes: const [auto], rowSizes: const [auto]);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/loading.dart';
import 'calendar_logic.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key}) : super(key: key);

  final logic = Get.put(CalendarLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('校历')),
      body: InteractiveViewer(
        maxScale: double.infinity,
        child: Obx(
          () => Center(
            child: logic.imgUrl.isEmpty
                ? Loading()
                : Image.network(logic.imgUrl.value),
          ),
        ),
      ),
    );
  }
}

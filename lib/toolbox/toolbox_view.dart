import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'toolbox_logic.dart';

class ToolboxPage extends StatelessWidget {
  ToolboxPage({Key? key}) : super(key: key);

  final logic = Get.put(ToolboxLogic());

  @override
  Widget build(BuildContext context) {
    return const Placeholder(color: Colors.red);
  }
}

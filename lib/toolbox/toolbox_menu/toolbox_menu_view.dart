import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'toolbox_menu_logic.dart';

class ToolboxMenuPage extends StatelessWidget {
  ToolboxMenuPage({Key? key}) : super(key: key);

  final logic = Get.put(ToolboxMenuLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工具箱'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            children: const [Placeholder()],
          ),
        ),
      ),
    );
  }
}

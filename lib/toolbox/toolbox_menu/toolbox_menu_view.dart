import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/database.dart';
import '../toolbox_view.dart';
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
          child: ValueListenableBuilder(
            valueListenable: conf.listenable(keys: ['toolbox']),
            builder: (_, __, ___) => ReorderableListView(
              children: tools.map((e) => e.toTile()).toList(),
              onReorder: toolbox.reorder,
            ),
          ),
        ),
      ),
    );
  }
}

class ToolTile extends StatelessWidget {
  const ToolTile(
    this.leading,
    this.title, {
    required Key key,
  }) : super(key: key);

  final IconData leading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(leading),
      title: Text(title),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'toolbox_logic.dart';

class ToolboxPage extends StatelessWidget {
  ToolboxPage({Key? key}) : super(key: key);

  final logic = Get.put(ToolboxLogic());

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 512,
      childAspectRatio: pi,
      children: [
        for (final tool in tools)
          Card(
            child: tool,
            color: context.theme.colorScheme.background,
            shadowColor: context.theme.colorScheme.onBackground,
          ),
      ],
    );
  }

  List<Widget> get tools => [];
}

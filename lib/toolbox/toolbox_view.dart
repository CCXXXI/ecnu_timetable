import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/messages.dart';
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
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 256),
                child: tool,
              ),
            ),
            color: context.theme.colorScheme.background,
            shadowColor: context.theme.colorScheme.onBackground,
          ),
      ],
    );
  }

  List<Widget> get tools => [
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.calendarAlt),
          title: const Text('校历'),
          subtitle: Text('师大还在用http'.s),
          onTap: logic.calendarOnTap,
        ),
      ];
}

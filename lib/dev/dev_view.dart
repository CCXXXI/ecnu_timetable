import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dev_logic.dart';

class DevPage extends StatelessWidget {
  DevPage({Key? key}) : super(key: key);

  final logic = Get.put(DevLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('开发者选项')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Trivia'),
            onTap: logic.triviaOnTap,
          )
        ],
      ),
    );
  }
}

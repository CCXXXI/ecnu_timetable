import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'secret_logic.dart';

class SecretPage extends StatelessWidget {
  SecretPage({Key? key}) : super(key: key);

  final logic = Get.put(SecretLogic());

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

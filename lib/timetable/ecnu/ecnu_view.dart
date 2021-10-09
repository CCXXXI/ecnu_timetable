import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ecnu_logic.dart';

class EcnuPage extends StatelessWidget {
  EcnuPage({Key? key}) : super(key: key);

  final logic = Get.put(EcnuLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自公共数据库导入课表'),
      ),
      body: Stepper(
        steps: const [
          Step(
            title: Text('登录公共数据库'),
            content: Placeholder(
              color: Colors.red,
            ),
          ),
          Step(
            title: Text('确认课表内容'),
            content: Placeholder(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

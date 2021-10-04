import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'juan_logic.dart';

class JuanWidget extends StatelessWidget {
  JuanWidget({Key? key}) : super(key: key);

  final logic = Get.put(JuanLogic());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: logic.aOnChanged,
              decoration: const InputDecoration(label: Text('已选')),
            ),
          ),
          Expanded(child: Center(child: Obx(() => Text(logic.r.value)))),
          Expanded(
            child: TextFormField(
              onChanged: logic.bOnChanged,
              decoration: const InputDecoration(label: Text('上限')),
            ),
          ),
        ],
      ),
    );
  }
}

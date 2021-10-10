import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'juan_logic.dart';

class JuanWidget extends StatelessWidget {
  JuanWidget({Key? key}) : super(key: key);

  final logic = Get.put(JuanLogic());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: logic.formKey,
      onChanged: logic.updateR,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(label: Text('已选')),
              controller: logic.aController,
              validator: logic.aValidator,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Center(child: Obx(() => Text(logic.r.value.toString()))),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(label: Text('上限')),
              controller: logic.bController,
              validator: logic.bValidator,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/messages.dart';
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
      body: Obx(
        () => Stepper(
          currentStep: logic.step.value,
          onStepContinue: logic.onStepContinue,
          controlsBuilder: controlsBuilder,
          steps: [
            Step(
              title: const Text('登录公共数据库'),
              subtitle: Text('密码仅用于登录，可至GitHub检查源码。'.s),
              content: const Placeholder(
                // todo
                color: Colors.red,
              ),
              state: logic.step.value == 0
                  ? StepState.indexed
                  : StepState.disabled,
            ),
            Step(
              title: const Text('确认课表内容'),
              subtitle: Text('有误可至GitHub反馈。'.s),
              content: const Placeholder(
                // todo
                color: Colors.green,
              ),
              state: logic.step.value == 1
                  ? StepState.indexed
                  : StepState.disabled,
            ),
          ],
        ),
      ),
    );
  }

  Widget controlsBuilder(BuildContext context, ControlsDetails details) =>
      ElevatedButton(
        onPressed: details.onStepContinue,
        child: Text(['登录', '完成'][details.stepIndex]),
      );
}

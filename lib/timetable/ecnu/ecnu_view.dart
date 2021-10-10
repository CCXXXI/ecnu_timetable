import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/loading.dart';
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
              content: Form(
                key: logic.loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('学号'),
                      ),
                      controller: logic.idController,
                      validator: logic.idValidator,
                      maxLength: 11,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('密码'),
                      ),
                      controller: logic.passwordController,
                      validator: logic.passwordValidator,
                      maxLength: TextField.noMaxLength,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onEditingComplete: logic.onStepContinue,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => logic.captchaController.value == null
                                ? Loading()
                                : TextFormField(
                                    decoration: const InputDecoration(
                                      label: Text('验证码'),
                                    ),
                                    controller: logic.captchaController.value,
                                    validator: logic.captchaValidator,
                                    maxLength: 4,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    keyboardType: TextInputType.number,
                                    onEditingComplete: logic.onStepContinue,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 42),
                        Obx(
                          () => logic.captchaImage.value.isEmpty
                              ? Loading()
                              : Image.memory(logic.captchaImage.value),
                        ),
                      ],
                    ),
                  ],
                ),
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

  Widget controlsBuilder(BuildContext context, ControlsDetails details) => Obx(
        () => logic.isLoading.isTrue
            ? Loading()
            : ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text(['登录', '完成'][details.stepIndex]),
              ),
      );
}

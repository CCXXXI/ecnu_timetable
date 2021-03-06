import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import '../../utils/loading.dart';
import '../../utils/string.dart';
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
          currentStep: logic.step.value.index,
          onStepContinue: logic.onStepContinue,
          controlsBuilder: logic.isLoading.isTrue
              ? (_, __) => Loading()
              : (_, details) => ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(['登录', '完成'][details.stepIndex]),
                  ),
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
                      validator: EcnuLogic.idValidator,
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
                      validator: EcnuLogic.passwordValidator,
                      maxLength: TextField.noMaxLength,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onEditingComplete: logic.onStepContinue,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text('验证码'),
                            ),
                            controller: logic.captchaController,
                            validator: EcnuLogic.captchaValidator,
                            maxLength: 4,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            onEditingComplete: logic.onStepContinue,
                            enabled: logic.captchaReady.value,
                          ),
                        ),
                        const SizedBox(width: 42),
                        logic.captchaImage.value.isEmpty
                            ? Loading()
                            : Image.memory(logic.captchaImage.value),
                      ],
                    ),
                  ],
                ),
              ),
              state: logic.step.value == S.login
                  ? StepState.indexed
                  : StepState.disabled,
            ),
            Step(
              title: const Text('选择学年学期'),
              subtitle: const Text('并确认课表内容无误。'),
              content: Column(
                children: [
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 200,
                          child: DropDownSettingsTile(
                            title: '学年',
                            settingKey: 'timetable.year.$hashCode',
                            selected: logic.year.value,
                            values: logic.years,
                            enabled: logic.isLoading.isFalse,
                            onChange: logic.yearOnChanged,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: DropDownSettingsTile(
                            title: '学期',
                            settingKey: 'timetable.semester.$hashCode',
                            selected: logic.semester.value,
                            values: logic.semesters,
                            enabled: logic.isLoading.isFalse,
                            onChange: logic.semesterOnChanged,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    logic.coursesPreview.value,
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                ],
              ),
              state: logic.step.value == S.check
                  ? StepState.indexed
                  : StepState.disabled,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import '../utils/messages.dart';

ThemeMode get _themeMode =>
    ThemeMode.values[Settings.getValue('themeMode', ThemeMode.system.index)];

bool get _dark =>
    _themeMode == ThemeMode.dark ||
    _themeMode == ThemeMode.system && Get.isPlatformDarkMode;

ThemeData get theme => ThemeData(
      brightness: _dark ? Brightness.dark : Brightness.light,
      fontFamily: fontSans,
    );

// void updateTheme() => Get.changeTheme(theme);
// todo: wait for https://github.com/jonataslaw/getx/issues/1878
void updateTheme() => Get.snackbar(
      '主题切换目前有 bug，请手动重启以使更改生效',
      'https://github.com/jonataslaw/getx/issues/1878',
      duration: const Duration(seconds: 10),
    );

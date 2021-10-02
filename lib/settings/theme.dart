import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import '../utils/messages.dart';

const _ecnuColorStr = '#ffa41f35';
final ecnuColor = ConversionUtils.colorFromString(_ecnuColorStr);

ThemeMode get _themeMode =>
    ThemeMode.values[Settings.getValue('themeMode', ThemeMode.system.index)];

bool get _dark =>
    _themeMode == ThemeMode.dark ||
    _themeMode == ThemeMode.system && Get.isPlatformDarkMode;

Color _c(String key) => Settings.getValue('overrideColor', false)
    ? ConversionUtils.colorFromString(
        Settings.getValue('color.$key', _ecnuColorStr))
    : ecnuColor;

ThemeData get theme => ThemeData.from(
      colorScheme: (_dark ? ColorScheme.dark : ColorScheme.light)(
        primary: _c('primary'),
        secondary: _c('secondary'),
        surface: _c('surface'),
      ),
      textTheme: (_dark ? ThemeData.dark : ThemeData.light)()
          .textTheme
          .apply(fontFamily: Settings.getValue('font', fontSans)),
    );

// void updateTheme() => Get.changeTheme(theme);
// todo: wait for https://github.com/jonataslaw/getx/issues/1878
void updateTheme() => Get.snackbar(
      '主题切换目前有 bug，请手动重启以使更改生效',
      'https://github.com/jonataslaw/getx/issues/1878',
      duration: const Duration(seconds: 10),
    );

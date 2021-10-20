import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/database.dart';
import '../utils/string.dart';

// region colorScheme
bool get _dark =>
    theme.mode_ == ThemeMode.dark ||
    theme.mode_ == ThemeMode.system && Get.isPlatformDarkMode;

ColorScheme get _colorScheme => (_dark ? ColorScheme.dark : ColorScheme.light)(
      primary: theme.primary,
      onPrimary: theme.onPrimary,
      secondary: theme.secondary,
      onSecondary: theme.onSecondary,
      surface: theme.surface,
      onSurface: theme.onSurface,
    );
// endregion

ThemeData get appTheme => ThemeData.from(
      colorScheme: _colorScheme,
      textTheme:
          theme.applyFont(_dark ? Typography().white : Typography().black),
    );

// void updateTheme() => Get.changeTheme(theme);
// todo: wait for https://github.com/jonataslaw/getx/issues/1878
void updateTheme() => Get.snackbar(
      '主题切换目前有bug，请手动重启以使更改生效'.s,
      'https://github.com/jonataslaw/getx/issues/1878',
    );

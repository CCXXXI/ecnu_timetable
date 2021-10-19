import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/database.dart' as db;
import '../utils/string.dart';

// region colorScheme
bool get _dark =>
    db.theme.mode_ == ThemeMode.dark ||
    db.theme.mode_ == ThemeMode.system && Get.isPlatformDarkMode;

ColorScheme get _colorScheme => (_dark ? ColorScheme.dark : ColorScheme.light)(
      primary: db.theme.primary,
      onPrimary: db.theme.onPrimary,
      secondary: db.theme.secondary,
      onSecondary: db.theme.onSecondary,
      surface: db.theme.surface,
      onSurface: db.theme.onSurface,
    );
// endregion

ThemeData get theme => ThemeData.from(
      colorScheme: _colorScheme,
      textTheme:
          db.theme.applyFont(_dark ? Typography().white : Typography().black),
    );

// void updateTheme() => Get.changeTheme(theme);
// todo: wait for https://github.com/jonataslaw/getx/issues/1878
void updateTheme() => Get.snackbar(
      '主题切换目前有bug，请手动重启以使更改生效'.s,
      'https://github.com/jonataslaw/getx/issues/1878',
    );

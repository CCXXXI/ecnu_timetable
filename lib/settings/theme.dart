import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

ThemeData _getTheme(ThemeData base) => base.copyWith();

ThemeMode get _themeMode => Settings.getValue('themeMode', ThemeMode.system);

ThemeData get theme => _getTheme(
      _themeMode == ThemeMode.dark ||
              _themeMode == ThemeMode.system && Get.isPlatformDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
    );

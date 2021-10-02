import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

ThemeData _getTheme(ThemeData base) => base.copyWith(); // todo

ThemeData get lightTheme => _getTheme(ThemeData.light());

ThemeData get darkTheme => _getTheme(ThemeData.dark());

ThemeMode get themeMode => Settings.getValue('themeMode', ThemeMode.system);

ThemeData get theme => themeMode == ThemeMode.dark ||
        themeMode == ThemeMode.system && Get.isDarkMode
    ? darkTheme
    : lightTheme;

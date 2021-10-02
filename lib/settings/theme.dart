import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

ThemeData get lightTheme => ThemeData.light(); // todo

ThemeData get darkTheme => ThemeData.dark(); // todo

ThemeMode get themeMode => Settings.getValue('themeMode', ThemeMode.system);

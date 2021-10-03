import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/messages.dart';

// region colorScheme
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

ColorScheme get _colorScheme => (_dark ? ColorScheme.dark : ColorScheme.light)(
      primary: _c('primary'),
      secondary: _c('secondary'),
      surface: _c('surface'),
    );
// endregion

// region textTheme
const _localFonts = {
  notoSans: '思源黑体',
  notoSerif: '思源宋体',
};
const _googleFonts = {
  'ZCOOL QingKe HuangYou': '站酷黄油',
  'ZCOOL XiaoWei': '站酷小薇',
  'ZCOOL KuaiLe': '站酷快乐',
  'Ma Shan Zheng': '钟齐善政',
  'Zhi Mang Xing': '钟齐志莽',
  'Liu Jian Mao Cao': '钟齐流江',
  'Long Cang': '有字龙藏',
};

const fonts = {'': '跟随系统', ..._localFonts, ..._googleFonts};

TextTheme get _baseTextTheme =>
    (_dark ? ThemeData.dark : ThemeData.light)().textTheme;

String get _font => Settings.getValue('font', notoSans);

TextTheme get _textTheme => _localFonts.containsKey(_font)
    ? _baseTextTheme.apply(fontFamily: _font)
    : _googleFonts.containsKey(_font)
        ? GoogleFonts.getTextTheme(_font, _baseTextTheme)
        : _baseTextTheme;
// endregion

ThemeData get theme =>
    ThemeData.from(colorScheme: _colorScheme, textTheme: _textTheme);

// void updateTheme() => Get.changeTheme(theme);
// todo: wait for https://github.com/jonataslaw/getx/issues/1878
void updateTheme() {
  if (!(Get.isSnackbarOpen ?? false)) {
    Get.snackbar(
      '主题切换目前有 bug，请手动重启以使更改生效',
      'https://github.com/jonataslaw/getx/issues/1878',
      duration: const Duration(days: 1),
    );
  }
}

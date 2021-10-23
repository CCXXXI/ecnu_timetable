import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';

import 'sentry.dart';
import 'string.dart';

part 'database.g.dart';

Future<void> initDatabase({bool clear = false}) async {
  if (!GetPlatform.isWeb && GetPlatform.isDesktop) {
    final dir = await getApplicationSupportDirectory();
    Hive.init(dir.path);
  } else {
    await Hive.initFlutter();
  }

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(LogAdapter());
  Hive.registerAdapter(ToolboxAdapter());
  Hive.registerAdapter(MiscAdapter());
  Hive.registerAdapter(ThemeAdapter());

  _conf = await Hive.openBox('conf');

  if (clear) await _conf.clear();

  if (!_conf.containsKey('user')) await _conf.put('user', _User());
  if (!_conf.containsKey('log')) await _conf.put('log', _Log());
  if (!_conf.containsKey('toolbox')) await _conf.put('toolbox', _Toolbox());
  if (!_conf.containsKey('misc')) await _conf.put('misc', _Misc());
  if (!_conf.containsKey('theme')) await _conf.put('theme', _Theme());

  Hive.registerAdapter(CourseAdapter());
  Hive.registerAdapter(PeriodAdapter());
  courses = await Hive.openBox('courses');
  if (clear) await courses.clear();
}

late final Box _conf;

@HiveType(typeId: 0)
class _User extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? password;

  @override
  Future<void> save() {
    updateUser();
    return super.save();
  }
}

final _User user = _conf.get('user');

@HiveType(typeId: 1)
class _Log extends HiveObject {
  @HiveField(0)
  String level = LogLevel.info.name;
  static final _levelMap = {for (final l in LogLevel.values) l.name: l};

  LogLevel get level_ => _levelMap[level]!;

  List<String> get levels => _levelMap.keys.toList();

  @HiveField(1)
  String stackTraceLevel = LogLevel.off.name;

  LogLevel get stackTraceLevel_ => _levelMap[stackTraceLevel]!;

  @HiveField(2)
  bool includeCallerInfo = false;
}

final _Log log = _conf.get('log');

@HiveType(typeId: 2)
class _Toolbox extends HiveObject {
  @HiveField(0)
  bool sucker = false;

  @HiveField(1)
  bool cheater = false;

  @HiveField(2)
  bool juan = false;
}

final _Toolbox toolbox = _conf.get('toolbox');

@HiveType(typeId: 3)
class _Misc extends HiveObject {
  @HiveField(0)
  String launchPage = '课程表';
  static final _pageMap = {
    '工具箱': 0,
    '课程表': 1,
    '设置': 2,
  };

  int get launchPage_ => _pageMap[launchPage]!;

  List<String> get pages => _pageMap.keys.toList();
}

final _Misc misc = _conf.get('misc');

@HiveType(typeId: 4)
class _Theme extends HiveObject {
  @HiveField(0)
  String mode = '跟随系统';
  static const _modeMap = {
    '跟随系统': ThemeMode.system,
    '开': ThemeMode.dark,
    '关': ThemeMode.light,
  };

  ThemeMode get mode_ => _modeMap[mode]!;

  List<String> get modes => _modeMap.keys.toList();

  @HiveField(1)
  String font = '思源黑体';
  static const _localFontMap = {
    '思源黑体': notoSans,
    '思源宋体': notoSerif,
  };
  static const _googleFontMap = {
    '站酷黄油': 'ZCOOL QingKe HuangYou',
    '站酷小薇': 'ZCOOL XiaoWei',
    '站酷快乐': 'ZCOOL KuaiLe',
    '钟齐善政': 'Ma Shan Zheng',
    '钟齐志莽': 'Zhi Mang Xing',
    '钟齐流江': 'Liu Jian Mao Cao',
    '有字龙藏': 'Long Cang',
  };

  List<String> get fonts => [
        '跟随系统',
        ..._localFontMap.keys,
        ..._googleFontMap.keys,
      ];

  TextTheme applyFont(TextTheme base) => _localFontMap.containsKey(font)
      ? base.apply(fontFamily: _localFontMap[font])
      : _googleFontMap.containsKey(font)
          ? GoogleFonts.getTextTheme(_googleFontMap[font]!, base)
          : base;

  @HiveField(2)
  bool overrideColor = false;

  static const _ecnu = 0xffa41f35;

  Color _on(Color color) =>
      color.computeLuminance() > .5 ? Colors.black : Colors.white;

  @HiveField(3)
  int _primary = _ecnu;

  Color get primary => Color(overrideColor ? _primary : _ecnu);

  set primary(Color primary) => _primary = primary.value;

  Color get onPrimary => _on(primary);

  @HiveField(4)
  int _secondary = _ecnu;

  Color get secondary => Color(overrideColor ? _secondary : _ecnu);

  set secondary(Color secondary) => _secondary = secondary.value;

  Color get onSecondary => _on(secondary);

  @HiveField(5)
  int _surface = _ecnu;

  Color get surface => Color(overrideColor ? _surface : _ecnu);

  set surface(Color surface) => _surface = surface.value;

  Color get onSurface => _on(surface);
}

final _Theme theme = _conf.get('theme');

@JsonSerializable()
@HiveType(typeId: 5)
class Course extends HiveObject {
  /// 数字，但可能有"21473957,77336"这种多教师共同授课的情况
  @HiveField(0)
  String? teacherId;

  @HiveField(1)
  String? teacherName;

  /// e.g. 334873
  @HiveField(2)
  String? courseId;

  /// e.g. SOFT0031132231
  @HiveField(3)
  String? courseCode;

  /// e.g. 01
  @HiveField(4)
  String? courseNo;

  @HiveField(5)
  String? courseName;

  @HiveField(6)
  String? roomId;

  @HiveField(7)
  String? roomName;

  @HiveField(8)
  List<bool>? weeks;

  @HiveField(9)
  String? taskId;

  @HiveField(10)
  String? expLessonGroupId;

  @HiveField(11)
  String? expLessonGroupIndexNo;

  @HiveField(12)
  String? remark;

  @HiveField(13)
  String? specialRoom;

  @JsonKey(toJson: _periodsToJson)
  @HiveField(14)
  List<Period>? periods;

  static _periodsToJson(List<Period>? periods) =>
      periods?.map((e) => e.toJson()).toList(growable: false);

  Course();

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  String toString() => toJson().toString();
}

late final Box<Course> courses;

@JsonSerializable()
@HiveType(typeId: 6)
class Period extends HiveObject {
  /// 0..6
  @HiveField(0)
  int? weekday;

  /// 0..12
  @HiveField(1)
  int? unit;

  Period();

  factory Period.fromJson(Map<String, dynamic> json) => _$PeriodFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodToJson(this);

  @override
  String toString() => toJson().toString();
}

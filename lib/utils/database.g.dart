// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<_User> {
  @override
  final int typeId = 0;

  @override
  _User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _User()
      ..id = fields[0] as String?
      ..name = fields[1] as String?
      ..password = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, _User obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LogAdapter extends TypeAdapter<_Log> {
  @override
  final int typeId = 1;

  @override
  _Log read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Log()
      ..level = fields[0] as String
      ..stackTraceLevel = fields[1] as String
      ..includeCallerInfo = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, _Log obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.stackTraceLevel)
      ..writeByte(2)
      ..write(obj.includeCallerInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ToolboxAdapter extends TypeAdapter<_Toolbox> {
  @override
  final int typeId = 2;

  @override
  _Toolbox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Toolbox()
      ..sucker = fields[0] as bool
      ..cheater = fields[1] as bool
      ..juan = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, _Toolbox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sucker)
      ..writeByte(1)
      ..write(obj.cheater)
      ..writeByte(2)
      ..write(obj.juan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToolboxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MiscAdapter extends TypeAdapter<_Misc> {
  @override
  final int typeId = 3;

  @override
  _Misc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Misc()..launchPage = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, _Misc obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.launchPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MiscAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeAdapter extends TypeAdapter<_Theme> {
  @override
  final int typeId = 4;

  @override
  _Theme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _Theme()
      ..mode = fields[0] as String
      ..font = fields[1] as String
      ..overrideColor = fields[2] as bool
      .._primary = fields[3] as int
      .._secondary = fields[4] as int
      .._surface = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, _Theme obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.mode)
      ..writeByte(1)
      ..write(obj.font)
      ..writeByte(2)
      ..write(obj.overrideColor)
      ..writeByte(3)
      ..write(obj._primary)
      ..writeByte(4)
      ..write(obj._secondary)
      ..writeByte(5)
      ..write(obj._surface);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CourseAdapter extends TypeAdapter<Course> {
  @override
  final int typeId = 5;

  @override
  Course read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course()
      ..teacherId = fields[0] as String?
      ..teacherName = fields[1] as String?
      ..courseId = fields[2] as int?
      ..courseCode = fields[3] as String?
      ..courseNo = fields[4] as String?
      ..courseName = fields[5] as String?
      ..roomId = fields[6] as int?
      ..roomName = fields[7] as String?
      ..weeks = (fields[8] as List?)?.cast<bool>()
      ..taskId = fields[9] as String?
      ..expLessonGroupId = fields[10] as String?
      ..expLessonGroupIndexNo = fields[11] as String?
      ..remark = fields[12] as String?
      ..specialRoom = fields[13] as String?;
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.teacherId)
      ..writeByte(1)
      ..write(obj.teacherName)
      ..writeByte(2)
      ..write(obj.courseId)
      ..writeByte(3)
      ..write(obj.courseCode)
      ..writeByte(4)
      ..write(obj.courseNo)
      ..writeByte(5)
      ..write(obj.courseName)
      ..writeByte(6)
      ..write(obj.roomId)
      ..writeByte(7)
      ..write(obj.roomName)
      ..writeByte(8)
      ..write(obj.weeks)
      ..writeByte(9)
      ..write(obj.taskId)
      ..writeByte(10)
      ..write(obj.expLessonGroupId)
      ..writeByte(11)
      ..write(obj.expLessonGroupIndexNo)
      ..writeByte(12)
      ..write(obj.remark)
      ..writeByte(13)
      ..write(obj.specialRoom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course()
  ..teacherId = json['teacherId'] as String?
  ..teacherName = json['teacherName'] as String?
  ..courseId = json['courseId'] as int?
  ..courseCode = json['courseCode'] as String?
  ..courseNo = json['courseNo'] as String?
  ..courseName = json['courseName'] as String?
  ..roomId = json['roomId'] as int?
  ..roomName = json['roomName'] as String?
  ..weeks = (json['weeks'] as List<dynamic>?)?.map((e) => e as bool).toList()
  ..taskId = json['taskId'] as String?
  ..expLessonGroupId = json['expLessonGroupId'] as String?
  ..expLessonGroupIndexNo = json['expLessonGroupIndexNo'] as String?
  ..remark = json['remark'] as String?
  ..specialRoom = json['specialRoom'] as String?;

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
      'courseId': instance.courseId,
      'courseCode': instance.courseCode,
      'courseNo': instance.courseNo,
      'courseName': instance.courseName,
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'weeks': instance.weeks,
      'taskId': instance.taskId,
      'expLessonGroupId': instance.expLessonGroupId,
      'expLessonGroupIndexNo': instance.expLessonGroupIndexNo,
      'remark': instance.remark,
      'specialRoom': instance.specialRoom,
    };

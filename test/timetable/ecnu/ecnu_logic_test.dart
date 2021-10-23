import 'package:ecnu_timetable/timetable/ecnu/ecnu_logic.dart';
import 'package:ecnu_timetable/utils/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';

void main() {
  setUpAll(() async {
    await initDatabase(clear: true);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('idValidator', () {
    expect(EcnuLogic.idValidator(null), isNotEmpty);
    expect(EcnuLogic.idValidator(''), isNotEmpty);
    expect(EcnuLogic.idValidator('123456'), isNotEmpty);
    expect(EcnuLogic.idValidator('123456' * 10), isNotEmpty);
    expect(EcnuLogic.idValidator('10101001000'), isNull);
  });

  test('passwordValidator', () {
    expect(EcnuLogic.passwordValidator(null), isNotEmpty);
    expect(EcnuLogic.passwordValidator(''), isNotEmpty);
    expect(EcnuLogic.passwordValidator('123456'), isNull);
    expect(EcnuLogic.passwordValidator('123456' * 10), isNull);
    expect(EcnuLogic.passwordValidator('10101001000'), isNull);
  });

  test('captchaValidator', () {
    expect(EcnuLogic.captchaValidator(null), isNotEmpty);
    expect(EcnuLogic.captchaValidator(''), isNotEmpty);
    expect(EcnuLogic.captchaValidator('1234'), isNull);
    expect(EcnuLogic.captchaValidator('123456'), isNotEmpty);
    expect(EcnuLogic.captchaValidator('10101001000'), isNotEmpty);
  });

  test('semester.id', () {
    expect(EcnuLogic.semId(2018, 0), 705);
    expect(EcnuLogic.semId(2018, 1), 705 + 32);
    expect(EcnuLogic.semId(2017, 2), 705 - 32);
  });

  test('parseIds', () {
    expect(
      EcnuLogic.parseIds('''
     	function searchTable(){
   		if(jQuery("#courseTableType").val()=="std"){
   			bg.form.addInput(form,"ids","123456");
   		}else{
   			bg.form.addInput(form,"ids","7890");
   		}
       	bg.form.submit(form,"courseTableForStd!courseTable.action","contentDiv");
   	}'''),
      '123456',
    );
  });

  test('parseCourses', () {
    final r = EcnuLogic.parseCourses(coursesJs);
    courses.addAll(r);
    expect(courses, isNotEmpty);
    expect(
      Course.fromJson(courses.getAt(0)!.toJson()).toJson(),
      r.first.toJson(),
    );
    expect(courses.toMap().toString(), res);
  });
}

const coursesJs = '''
	// function CourseTable in TaskActivity.js
	var table0 = new CourseTable(2021,98);
	var unitCount = 14;
	var index=0;
	var activity=null;
			activity = new TaskActivity("76694","赵慧","340936(SOFT0031132992.01)","非关系型数据存储技术及其应用(SOFT0031132992.01)","2375","教书院226","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =3*unitCount+2;
			table0.activities[index][table0.activities[index].length]=activity;
			index =3*unitCount+3;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76646","姜宁康","302608(SOFT0031131018.01)","面向对象分析和设计实践(SOFT0031131018.01)","5036","理科大楼B517","00101010101010101000000000000000000000000000000000000",null,"","","","");
			index =1*unitCount+5;
			table0.activities[index][table0.activities[index].length]=activity;
			index =1*unitCount+6;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76646","姜宁康","292975(SOFT0031131073.01)","面向对象分析和设计(SOFT0031131073.01)","2375","教书院226","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =1*unitCount+0;
			table0.activities[index][table0.activities[index].length]=activity;
			index =1*unitCount+1;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76848","羊丹平","340398(MATH0031112991.02)","逻辑·推理·证明(MATH0031112991.02)","2370","教书院218","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =0*unitCount+10;
			table0.activities[index][table0.activities[index].length]=activity;
			index =0*unitCount+11;
			table0.activities[index][table0.activities[index].length]=activity;
			index =0*unitCount+12;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76447","应琼","343774(COEN0031162002.04)","中西文化比较(COEN0031162002.04)","2377","教书院302","01111111111111111000000000000000000000000000000000000",null,"","","","");
			index =4*unitCount+2;
			table0.activities[index][table0.activities[index].length]=activity;
			index =4*unitCount+3;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76743","赵世忠","295546(SOFT0031132019.01)","数学建模(SOFT0031132019.01)","2370","教书院218","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =0*unitCount+7;
			table0.activities[index][table0.activities[index].length]=activity;
			index =0*unitCount+8;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76663","孙海英","331020(SOFT0031132228.01)","软件测试和验证(SOFT0031132228.01)","2609","理科大楼B226","01111110111111111100000000000000000000000000000000000",null,"","","","");
			index =1*unitCount+2;
			table0.activities[index][table0.activities[index].length]=activity;
			index =1*unitCount+3;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("24935984","程鹏","334873(SOFT0031132231.01)","算法设计与分析(SOFT0031132231.01)","2370","教书院218","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =3*unitCount+5;
			table0.activities[index][table0.activities[index].length]=activity;
			index =3*unitCount+6;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76663","孙海英","331020(SOFT0031132228.01)","软件测试和验证(SOFT0031132228.01)","","","00000000100000000000000000000000000000000000000000000",null,"","","","理科楼B226");
			index =0*unitCount+0;
			table0.activities[index][table0.activities[index].length]=activity;
			index =0*unitCount+1;
			table0.activities[index][table0.activities[index].length]=activity;
	table0.marshalTable(2,1,18);
	fillTable(table0,7,14,0);
''';
const res =
    '{0: {teacherId: 76694, teacherName: 赵慧, courseId: 340936, courseCode: SOFT0031132992, courseNo: 01, courseName: 非关系型数据存储技术及其应用, roomId: 2375, roomName: 教书院226, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 3, unit: 2}, {weekday: 3, unit: 3}]}, 1: {teacherId: 76646, teacherName: 姜宁康, courseId: 302608, courseCode: SOFT0031131018, courseNo: 01, courseName: 面向对象分析和设计实践, roomId: 5036, roomName: 理科大楼B517, weeks: [false, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 1, unit: 5}, {weekday: 1, unit: 6}]}, 2: {teacherId: 76646, teacherName: 姜宁康, courseId: 292975, courseCode: SOFT0031131073, courseNo: 01, courseName: 面向对象分析和设计, roomId: 2375, roomName: 教书院226, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 1, unit: 0}, {weekday: 1, unit: 1}]}, 3: {teacherId: 76848, teacherName: 羊丹平, courseId: 340398, courseCode: MATH0031112991, courseNo: 02, courseName: 逻辑·推理·证明, roomId: 2370, roomName: 教书院218, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 0, unit: 10}, {weekday: 0, unit: 11}, {weekday: 0, unit: 12}]}, 4: {teacherId: 76447, teacherName: 应琼, courseId: 343774, courseCode: COEN0031162002, courseNo: 04, courseName: 中西文化比较, roomId: 2377, roomName: 教书院302, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 4, unit: 2}, {weekday: 4, unit: 3}]}, 5: {teacherId: 76743, teacherName: 赵世忠, courseId: 295546, courseCode: SOFT0031132019, courseNo: 01, courseName: 数学建模, roomId: 2370, roomName: 教书院218, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 0, unit: 7}, {weekday: 0, unit: 8}]}, 6: {teacherId: 76663, teacherName: 孙海英, courseId: 331020, courseCode: SOFT0031132228, courseNo: 01, courseName: 软件测试和验证, roomId: 2609, roomName: 理科大楼B226, weeks: [false, true, true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 1, unit: 2}, {weekday: 1, unit: 3}]}, 7: {teacherId: 24935984, teacherName: 程鹏, courseId: 334873, courseCode: SOFT0031132231, courseNo: 01, courseName: 算法设计与分析, roomId: 2370, roomName: 教书院218, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 3, unit: 5}, {weekday: 3, unit: 6}]}, 8: {teacherId: 76663, teacherName: 孙海英, courseId: 331020, courseCode: SOFT0031132228, courseNo: 01, courseName: 软件测试和验证, roomId: , roomName: , weeks: [false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: 理科楼B226, periods: [{weekday: 0, unit: 0}, {weekday: 0, unit: 1}]}}';
